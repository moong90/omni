package com.brave.thebrave.api.controller;

import com.brave.thebrave.api.request.MenuRequest;
import com.brave.thebrave.api.response.CommonDefaultResponse;
import com.brave.thebrave.api.response.ContentsHistoryRequest;
import com.brave.thebrave.api.response.ContentsHistoryResponse;
import com.brave.thebrave.api.response.MenuListResponse;
import com.brave.thebrave.api.service.ContentService;
import com.brave.thebrave.api.service.MenuService;
import com.brave.thebrave.api.vo.MainContentsVo;
import com.brave.thebrave.api.vo.MenuVo;
import com.brave.thebrave.exception.runtime.ServerBrvRuntimException;
import com.brave.thebrave.exception.runtime.common.NotificationRuntimeBrvException;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/api/menu")
public class MenuController {

    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    private final MenuService menuService;
    private final ContentService contentService;

    /**
     * 메뉴 기본정보 저장
     * @param request
     * @param session
     * @param menuRequest
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse save(HttpServletRequest request, HttpSession session, @RequestBody MenuRequest menuRequest) throws Exception {

        if (session.getAttribute("loginId") == null) {
            return new CommonDefaultResponse(1007, "로그인이 필요한 기능입니다.");
        }

        try {

            // 최대Level 값 추출
            int maxLevel = menuService.selectMaxLevel(menuRequest.getParent());

            menuRequest.setLevel(maxLevel);

            if (menuRequest.getLangType().equals("ENG")) {
                menuRequest.setMenuName2(menuRequest.getMenuName());
                menuRequest.setMenuName("");
            }

            // 메뉴 기본정보 저장
            int cnt = menuService.saveMenuDefault(menuRequest);

            if (cnt == 0) {
                throw new ServerBrvRuntimException("메뉴등록중 오류가 발생하였습니다.");
            }
            return new CommonDefaultResponse(200, "success");

        } catch (Exception e) {
            e.printStackTrace();
            return new CommonDefaultResponse(400, e.getMessage());
        }

    }

    /**
     * 메뉴 기본정보 수정
     * @param session
     * @param request
     * @param menuRequest
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse update(HttpSession session, HttpServletRequest request, @RequestBody MenuRequest menuRequest) throws Exception {

        if (session.getAttribute("loginId") == null) {
            return new CommonDefaultResponse(1007, "로그인이 필요한 기능입니다.");
        }

        try {

            // 메뉴 기본정보 수정
            int cnt = menuService.updateMenuDefault(menuRequest);

            if (cnt == 0) {
                throw new ServerBrvRuntimException("메뉴수정중 오류가 발생하였습니다.");
            }

            return new CommonDefaultResponse(200, "success");
        } catch (Exception e) {
            e.printStackTrace();

            return new CommonDefaultResponse(400, e.getMessage());
        }

    }

    /**
     * 메뉴 사용여부 저장
     * @param request
     * @param session
     * @param menu_seq
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/use_yn/{menu_seq}", method = RequestMethod.GET)
    @ResponseBody
    public CommonDefaultResponse use_y(HttpServletRequest request, HttpSession session,
                                       @PathVariable String menu_seq) throws Exception {
        if (session.getAttribute("loginId") == null) {
            return new CommonDefaultResponse(1007, "로그인이 필요한 기능입니다.");
        }

        try {
            MenuVo menuVo = new MenuVo();
            MenuVo getmenuVo = menuService.selectMenuOne(Integer.valueOf(menu_seq));

            if (getmenuVo.getUseYn().equals("Y")) {
                menuVo.setUseYn("N");
                menuVo.setMenuSeq(Integer.valueOf(menu_seq));
            } else {
                menuVo.setUseYn("Y");
                menuVo.setMenuSeq(Integer.valueOf(menu_seq));
            }

            //메뉴등록
            menuService.saveMenuUpdateUseYN(menuVo);

            return new CommonDefaultResponse(200, "success");
        } catch (Exception e) {
            e.printStackTrace();

            return new CommonDefaultResponse(400, e.getMessage());
        }
    }

    /**
     * 메뉴 삭제
     * @param session
     * @param menuSeq
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/delete/{menuSeq}", method = RequestMethod.DELETE)
    @ResponseBody
    public CommonDefaultResponse menuDelete(HttpSession session, @PathVariable(name = "menuSeq") String menuSeq) {

        try {

            if (session.getAttribute("loginId") == null) {
                return new CommonDefaultResponse(1007, "로그인이 필요한 기능입니다.");
            }

            List<MenuListResponse> list = menuService.childMenuList(menuSeq);

            if (list.size() > 0) {

                throw new NotificationRuntimeBrvException("하위메뉴가 존재합니다. 하위메뉴를 먼저 삭제해주시기바랍니다.");

            } else {

                int cnt = menuService.deleteMenuData(Integer.parseInt(menuSeq));

                if (cnt == 0) {
                    throw new NotificationRuntimeBrvException("메뉴 삭제 도중 에러가 발생하였습니다.");
                }
            }

            return new CommonDefaultResponse(200, "success");

        } catch (Exception e) {
            e.printStackTrace();
            return new CommonDefaultResponse(400, e.getMessage());
        }

    }

    /**
     * 컨텐츠 히스토리 정보 조회
     *
     * @param request
     * @return
     */
    @PostMapping(value = "/contents/getContentsHistoryInfo")
    @ResponseBody
    public ContentsHistoryResponse getContentsHistoryInfo(@RequestBody ContentsHistoryRequest request) {
        return contentService.getContentsHistoryInfo(request.getContentsHisSeq());
    }

    /**
     * 컨텐츠 히스토리 삭제
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/contents/deleteContentsHistory", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse deleteContentsHistory(@RequestBody ContentsHistoryRequest request) {

        try {

            int cnt = contentService.deleteContentsHistory(request.getContentsHisSeq());

            if (cnt == 0) {
                throw new NotificationRuntimeBrvException("컨텐츠 히스토리 삭제 처리에 실패하였습니다.");
            }

            return new CommonDefaultResponse(200, "success");
        } catch (Exception e) {
            return new CommonDefaultResponse(400, e.getMessage());
        }

    }

    /**
     * 메인 컨텐츠 저장
     *
     * @param contents
     * @param contents2
     * @param contents3
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/main/save", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse mainSave(@RequestParam(value = "contents", required = false) String contents,      // 한국어
                                          @RequestParam(value = "contents2", required = false) String contents2,    // 영어
                                          @RequestParam(value = "contents3", required = false) String contents3,    // 베트남어
                                          @RequestParam(value = "contents4", required = false) String contents4     // 일본어
    ) throws Exception {

        try {

            MainContentsVo mainContentsVo = new MainContentsVo();
            mainContentsVo.setContents(contents);
            mainContentsVo.setContentsEng(contents2);
            mainContentsVo.setContentsJpn(contents3);
            mainContentsVo.setContentsVt(contents4);

            int cnt = menuService.saveMainContents(mainContentsVo);

            if (cnt == 0) {
                throw new NotificationRuntimeBrvException("메인 컨텐츠 저장에 실패하였습니다.");
            }

            return new CommonDefaultResponse(200, "success");

        } catch (Exception e) {
            return new CommonDefaultResponse(400, e.getMessage());
        }
    }

    /**
     * 선택된 메뉴의 하위 메뉴 리스트 조회
     * @param menuSeq
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/childMenu/{menuSeq}", method = RequestMethod.POST)
    @ResponseBody
    public List<MenuListResponse> childMenu(@PathVariable(name = "menuSeq") String menuSeq) throws Exception{

        /**
         * 선택된 메뉴의 하위 메뉴 리스트 조회
         */
        List<MenuListResponse> list = menuService.childMenuList(menuSeq);

        return list;

    }

    /**
     * 메뉴 컨텐츠 정보 저장
     * @param session
     * @param menuRequest
     * @return
     */
    @RequestMapping(value = "/contents/save", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse contentsSave(HttpSession session, @RequestBody MenuRequest menuRequest) {

        if (session.getAttribute("loginId") == null) {
            return new CommonDefaultResponse(1007, "로그인이 필요한 기능입니다.");
        }

        if (menuRequest.getMenuSeq() == null || menuRequest.getMenuSeq().equals("")) {
            return new CommonDefaultResponse(1007, "menuSeq는 필수값입니다.");
        }

        try {

            menuService.contentsSaveProcess(menuRequest);

            return new CommonDefaultResponse(200, "success");

        } catch (Exception e) {
            e.printStackTrace();
            return new CommonDefaultResponse(400, e.getMessage());
        }

    }

    /**
     * 수정 데이터 조회
     * @param session
     * @param request
     * @param menuSeq
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getMenuData/{menuSeq}", method = RequestMethod.POST)
    @ResponseBody
    public MenuVo getMenuData(HttpSession session, HttpServletRequest request, @PathVariable(name = "menuSeq") String menuSeq) {

        MenuVo response = menuService.selectMenuOne(Integer.parseInt(menuSeq));

        if (response == null || response.equals("")) {
            throw new NotificationRuntimeBrvException("해당 메뉴 정보가 없습니다. 다시 확인해주세요.");
        }
        return response;
    }

    /**
     * 메뉴 순서변경
     * @param session
     * @param direction
     * @param menuSeq
     * @param parent
     * @param level
     * @return
     */
    @RequestMapping(value = "/levelChange/{direction}/{menuSeq}/{parent}/{level}", method = RequestMethod.POST)
    @ResponseBody
    public CommonDefaultResponse levelChange(HttpSession session,
                                             @PathVariable(name = "direction") String direction,
                                             @PathVariable(name = "menuSeq") String menuSeq,
                                             @PathVariable(name = "parent") String parent,
                                             @PathVariable(name = "level") String level
    ) {

        if (session.getAttribute("loginId") == null) {
            return new CommonDefaultResponse(1007, "로그인이 필요한 기능입니다.");
        }

        try {

            MenuVo menuVo = new MenuVo();
            menuVo.setParent(Integer.parseInt(parent));
            menuVo.setMenuSeq(Integer.parseInt(menuSeq));

            if (direction.equals("UP")) {                // 위로 이동

                // 이동 시킬 위치의 레벨 세팅
                int lv = Integer.parseInt(level) - 1;
                menuVo.setLevel(lv);
                menuVo.setDirection("UP");

            } else if (direction.equals("DOWN")) {       // 아래로 이동

                // 이동 시킬 위치의 레벨 세팅
                int lv = Integer.parseInt(level) + 1;
                menuVo.setLevel(lv);
                menuVo.setDirection("DOWN");

                // 이동시킬 메뉴가 있는지 체크
                int cnt = menuService.checkLevelMenu(menuVo);

                // 이동키실 메뉴가 없을 경우 Exception
                if (cnt == 0) {
                    return new CommonDefaultResponse(6000, "최하위 메뉴입니다.");
                }
            }

            // 기존 레벨에 있는 메뉴 아래로 이동
            menuService.setMenuDirectionDown(menuVo);

            // 타켓 메뉴 위로 이동
            menuService.setMenuDirectionUp(menuVo);

            return new CommonDefaultResponse(200, "SUCCESS");

        } catch (Exception e) {
            e.printStackTrace();
            return new CommonDefaultResponse(400, e.getMessage());
        }

    }

}
