package com.brave.thebrave.view.controller;

import com.brave.thebrave.api.response.*;
import com.brave.thebrave.api.service.*;
import com.brave.thebrave.api.vo.*;
import com.brave.thebrave.exception.runtime.BaseBrvRuntimeException;
import com.brave.thebrave.util.paging.PagingResponse;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 관리자 화면 처리 제어를 하는 Controller
 */
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/admin")
public class AdminViewController{

	protected Logger log = LoggerFactory.getLogger(this.getClass());

	private final BoardService boardService;
	private final MenuService menuService;
	private final FooterService footerService;

	private final ContentService contentService;

	private final AdminService adminService;
	
	@RequestMapping(value="")
	public ModelAndView index(HttpServletRequest request, HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();

		if(session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/view/login");
		}else {
			modelAndView.setViewName("redirect:/admin/menu/1");
		}
		return modelAndView;
	}

	/**
	 * 메뉴관리
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/menu/{menu_seq}")
	public ModelAndView menu(HttpSession session, @PathVariable(name = "menu_seq") String menu_seq) {
		ModelAndView modelAndView = new ModelAndView();

		if (session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}

		if (menu_seq.isEmpty()) {
			menu_seq = "1";
		}

		modelAndView.setViewName("admin/menu");
		List<MenuListResponse> list = null;
		List<MenuTreeListResponse> menuTreeList = null;

		try {

			list = menuService.getList(Integer.valueOf(menu_seq));
			menuTreeList = menuService.getMenuTreeList(null);

			// 1Depth 메뉴만 조회
			List<MenuListResponse> oneDepthList = menuService.getOneDepthMenuList();

			MenuVo menuVo = menuService.selectMenuOne(Integer.valueOf(menu_seq));

			SearchFilterVo filter = new SearchFilterVo();

			modelAndView.addObject("oneDepthList", oneDepthList);
			modelAndView.addObject("parentInfo",menuVo);

		} catch (Exception e) {
			 throw new BaseBrvRuntimeException(e);
		}
		modelAndView.addObject("list", list);
		modelAndView.addObject("menuTreeList", menuTreeList);
		modelAndView.addObject("parent", menu_seq);
		modelAndView.addObject("oneDepthList", leftMenuList());
		modelAndView.addObject("board_title", "메뉴관리");

		return modelAndView;
	}

	/**
	 * Left메뉴 페이지관리 1depth 메뉴 리스트 조회
	 * @return
	 */
	private List<MenuListResponse> leftMenuList() {

		List<MenuListResponse> list = menuService.getOneDepthMenuList();

		return list;
	}

	/**
	 * 메뉴등록
	 * @param session
	 * @return
	 */
	@RequestMapping( value = "/menu/add/{parent}" )
	public ModelAndView menuAdd(HttpSession session, @PathVariable String parent) {
		ModelAndView modelAndView = new ModelAndView();

		if (session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}

		MenuVo menuVo = menuService.selectMenuOne(Integer.valueOf(parent));

		modelAndView.addObject("parentInfo",menuVo);

		modelAndView.setViewName("admin/menuadddetail");
		modelAndView.addObject("board_title", "메뉴등록");
		return modelAndView;
	}

	/**
	 * 메뉴 수정
	 * @param session
	 * @param menu_seq
	 * @return
	 */
	@RequestMapping(value="/menu/modify/{menu_seq}")
	public ModelAndView menuModi(HttpSession session, @PathVariable String menu_seq){
		ModelAndView modelAndView = new ModelAndView();
		if(session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}

		//메뉴정보 select
		MenuVo menuVo = menuService.selectMenuOne(Integer.valueOf(menu_seq));
		modelAndView.addObject("menuInfo",menuVo);

		//상위 메뉴 정보 select
		MenuVo parentMenuVo = menuService.selectMenuOne(menuVo.getParent());
		modelAndView.addObject("parentInfo",parentMenuVo);

		// 컨텐츠 히스토리 조회
		List<ContentsHistoryVo> contsList = contentService.selectContentHistoryList(menu_seq);

		modelAndView.addObject("board_title", "메뉴수정");
		modelAndView.addObject("contsList", contsList);
		modelAndView.setViewName("admin/menumodi");

		return modelAndView;
	}

	/**
	 * 푸터 관리
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/footer")
	public ModelAndView footerModi(HttpSession session){
		ModelAndView modelAndView = new ModelAndView();

		if (session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}

		FooterVo footerVo = footerService.selectFooterOne();

		modelAndView.addObject("board_title", "Footer관리");
		modelAndView.addObject("footerVo", footerVo);
		modelAndView.setViewName("admin/footermodi");

		return modelAndView;
	}

	/**
	 * 메인페이지 관리
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/mainPage")
	public ModelAndView mainPageView(HttpSession session){
		ModelAndView modelAndView = new ModelAndView();

		if(session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}

		modelAndView.setViewName("admin/mainPage");

		try {
			MainContentsResponse res = menuService.getMainContents();
			modelAndView.addObject("res", res);
		} catch (Exception e) {
			throw new BaseBrvRuntimeException(e);
		}
		return modelAndView;
	}

	/**
	 * 문의 리스트
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/inquiryList")
	public ModelAndView contactList(HttpSession session,
								 @ModelAttribute("params") final SearchFilterVo params,
								 @RequestParam(value = "searchKey", required = false) String searchKey,
								 @RequestParam(value = "searchWord", required = false) String searchWord){
		ModelAndView modelAndView = new ModelAndView();
		if(session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}
		modelAndView.setViewName("admin/inquiryList");

		List<InquiryResponse> list = null;
		try {
			list = boardService.getInquiryList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		params.setSearchKey(searchKey);
	    params.setSearchWord(searchWord);
		PagingResponse<InquiryResponse> response = adminService.inquiryPagingList(params);
		modelAndView.addObject("response", response);
		modelAndView.addObject("list", list);
		modelAndView.addObject("board_title", "문의 관리");
		return modelAndView;
	}
	
	/**
	 * 문의 상세 보기
	 * @param session
	 * @param seq
	 * @return
	 */
	@RequestMapping(value="/inquiryView/{seq}")
	public ModelAndView contactView(HttpSession session, @PathVariable(name = "seq") String seq){
		ModelAndView modelAndView = new ModelAndView();
		if(session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}
		modelAndView.setViewName("admin/inquiryView");

		InquiryResponse response = boardService.getInquiryOne(seq);

		response.setOrgName(null);
		response.setFileName(null);

		modelAndView.addObject("response", response);
		modelAndView.addObject("board_title", "문의 상세");
		return modelAndView;
	}

	/**
	 * 페이지 관리 폼
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/pageMng")
	public ModelAndView pageMng(HttpSession session){
		ModelAndView modelAndView = new ModelAndView();

		if(session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}

		modelAndView.setViewName("admin/pageMng");

		try {

			List<MenuTreeListResponse> menuTreeList = menuService.getAdminMenuTreeList();


			modelAndView.addObject("menuTreeList", menuTreeList);
			modelAndView.addObject("board_title", "페이지 관리");

		} catch (Exception e) {
			throw new BaseBrvRuntimeException(e);
		}
		return modelAndView;
	}

	/**
	 * 페이지 수정 폼
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/pageModify/{menuSeq}")
	public ModelAndView pageModify(HttpSession session, @PathVariable(name = "menuSeq") String menuSeq){
		ModelAndView modelAndView = new ModelAndView();

		if(session.getAttribute("loginId") == null) {
			modelAndView.setViewName("redirect:/admin");
			return modelAndView;
		}

		modelAndView.setViewName("admin/pageModify");

		try {

			MenuVo menuVo = menuService.selectMenuOne(Integer.valueOf(menuSeq));

			if (menuVo.getLangType().equals("KOR")) {

			} else if (menuVo.getLangType().equals("ENG")) {
				menuVo.setContents(menuVo.getContents2());
			} else if (menuVo.getLangType().equals("JPN")) {
				menuVo.setContents(menuVo.getContents3());
			}

			modelAndView.addObject("menuVo", menuVo);
			modelAndView.addObject("board_title", menuVo.getParentMenuName() + " : " + menuVo.getMenuName());

		} catch (Exception e) {
			throw new BaseBrvRuntimeException(e);
		}
		return modelAndView;
	}
}