package com.brave.thebrave.view.controller;

import com.brave.thebrave.api.request.SelectMenuOneNameRequest;
import com.brave.thebrave.api.response.*;
import com.brave.thebrave.api.service.*;
import com.brave.thebrave.api.vo.*;
import com.brave.thebrave.dao.BoardDao;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * 메인 페이지 및 사용자 화면을 제어 하는 Controller
 *
 * ## 기본 세팅
 *  > 언어는 `국문`, `영문`을 기본으로 세팅 한다.
 *  > 추가 언어 요청 시에는 추가 개발이 필요하다.
 */
@Tag(name = "메인 API" , description = "메인페이지를 관리하기 위한 API")
@RestController
@RequiredArgsConstructor
public class MainController {

    private final Logger requestTraceLogger = LoggerFactory.getLogger("REQUEST_TRACE_LOGGER");

    private final MenuService menuService;
    private final BoardService boardService;
    private final FooterService footerService;

    private final BoardDao boardDao;

    @Value("${site.domain.name}")
    private String siteDomain;

    @Value("${site.domain.default}")
    private String siteDomainDefault;

    @Value("${dir.file-path.board.eng}")
    private String dirFilePathBoardEng;

    @Value("${dir.file-path.page.eng}")
    private String dirFilePathPageEng;

    @Operation(summary = "메인페이지", description = "메인페이지 API")
    @GetMapping(value = "/robots.txt")
    public String robots() {
        return "User-agent: *\nAllow:/\n";
    }

    /**
     * 디폴트 경로 접근
     * @param request
     * @return
     */
    @RequestMapping("/")
    public RedirectView exRedirect4(HttpServletRequest request) {
        RedirectView redirectView = new RedirectView();
        redirectView.setUrl(siteDomainDefault);
        return redirectView;
    }

    /**
     * 영문 메인
     * @param session
     * @return
     */
    @RequestMapping("/ENG")
    public RedirectView engrRedirect(HttpSession session){
        RedirectView redirectView = new RedirectView();
        session.setAttribute("sessionLanguage", "ENG");
        redirectView.setUrl("/" + siteDomain);
        return redirectView;
    }

    @GetMapping(value = "/${site.domain.name}")
    public ModelAndView intro(HttpServletRequest request, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        String language = addLanguage(session, modelAndView);
        // Footer, MenuTree 조회
        addCommonData(modelAndView, language);
        // 메인 페이지 Contents 조회
        addMainContents(modelAndView);
        modelAndView.setViewName("/index_eng");

        return modelAndView;
    }

    /**
     * 서브메뉴 전체 접근을 제어 한다.
     **/
    @Operation(summary = "서브페이지", description = "서브페이지 접근을 위한 API")
    @Parameters({
        @Parameter(name = "params", description = "화면에서 넘어오는 Param", required = true),
        @Parameter(name = "searchKey", description = "검색키가 있는 경우 사용", required = false),
        @Parameter(name = "searchWord", description = "검색어가 있는 경우 사용", required = false)
    })
    @RequestMapping(value="/${site.domain.name}/**/{menu_name}")
    public ModelAndView gate_menu_name(
                                        HttpServletRequest request,
                                        HttpSession session,
                                        @PathVariable String menu_name,
                                        @ModelAttribute("params") final SearchFilterVo params,
                                        @RequestParam(value = "searchKey", required = false) String searchKey,
                                        @RequestParam(value = "searchWord", required = false) String searchWord
                                        ){
        ModelAndView modelAndView = new ModelAndView();
        String language = addLanguage(session, modelAndView);

        // Footer, MenuTree 조회
        addCommonData(modelAndView, language);

        // 대상 페이지 메뉴 정보
        MenuVo menuVo = addMenuVo(modelAndView, menu_name, language);

        // 대상 페이지 메뉴 카테고리 정보
        List<MenuListResponse> menuCategoryList = menuService.getListUse(1);
        modelAndView.addObject("menuCategoryList", menuCategoryList);

        /**
         * ## 메뉴 타입에 따른 페이지 분개 처리
         *
         * PAGE     : 페이지 타입 ( Contents 페이지 )
         * ACTION   : 개발이 필요한 페이지 타입
         */
        switch (menuVo.getMenuType()){
            case "PAGE":
                modelAndView.setViewName( dirFilePathPageEng + "/viewPage_eng");
                break;
            case "ACTION":
                modelAndView.setViewName("action/" + menuVo.getUrlname() + "_eng");
                break;
            case "LINK":
                String url = menuVo.getLink();
                RedirectView rv = new RedirectView();
                rv.setExposeModelAttributes(false);
                rv.setUrl(url);
                modelAndView.setView(rv);
                break;
        }
        return modelAndView;
    }

    // ===================================================
    // private 메서드
    // ===================================================

    /**
     * 공통 데이터 ModelAndView 추가
     * - 상단 메뉴 목록 (menuTreeList)
     * - 푸터 정보 (footerVo)
     */
    private void addCommonData(ModelAndView modelAndView, String language) {
        // 상단 메뉴 List
        List<MenuTreeListResponse> menuTreeList = menuService.getMenuTreeList(language);
        modelAndView.addObject("menuTreeList", menuTreeList);

        // Footer
        FooterVo footerVo = footerService.selectFooterOne();
        modelAndView.addObject("footerVo", footerVo);
    }

    /**
     * 세션에서 언어 설정을 가져오거나 초기화하여 ModelAndView 에 추가
     * - 세션에 언어가 없으면 기본 언어(siteDomainDefault)로 설정
     * - 언어 정보를 ModelAndView에 "language" 키로 추가
     *
     * @param session HTTP 세션
     * @param modelAndView 언어 정보를 추가할 ModelAndView 객체
     * @return 현재 언어 설정 값 (예: "KO", "ENG")
     */
    private String addLanguage(HttpSession session, ModelAndView modelAndView) {
        String language = siteDomainDefault;

        if (session.getAttribute("sessionLanguage") != null) {
            session.setAttribute("sessionLanguage", session.getAttribute("sessionLanguage"));
            language = session.getAttribute("sessionLanguage").toString();
        } else {
            session.setAttribute("sessionLanguage", language);
        }
        modelAndView.addObject("language",language);
        return language;
    }

    /**
     * 메인 페이지 컨텐츠 정보를 ModelAndView에 추가
     *
     * @param modelAndView 메인 컨텐츠 정보를 추가할 ModelAndView 객체
     */
    private void addMainContents(ModelAndView modelAndView) {
        MainContentsResponse mainRes = menuService.getMainContents();
        modelAndView.addObject("mainRes", mainRes);
    }

    private MenuVo addMenuVo(ModelAndView modelAndView, String menuName, String langType) {
        SelectMenuOneNameRequest request = new SelectMenuOneNameRequest();
        request.setMenuName(menuName);
        request.setLangType("KR".equals(langType) ? "KOR" : langType);
        MenuVo menuVo = menuService.selectMenuOneName(request);
        modelAndView.addObject("menuVo", menuVo);
        return menuVo;
    }
}
