package com.brave.thebrave.api.service;

import com.brave.thebrave.api.request.MenuRequest;
import com.brave.thebrave.api.request.SelectMenuOneNameRequest;
import com.brave.thebrave.api.response.MainContentsResponse;
import com.brave.thebrave.api.response.MenuListResponse;
import com.brave.thebrave.api.response.MenuTreeListResponse;
import com.brave.thebrave.api.vo.ContentVo;
import com.brave.thebrave.api.vo.ContentsHistoryVo;
import com.brave.thebrave.api.vo.MainContentsVo;
import com.brave.thebrave.api.vo.MenuVo;
import com.brave.thebrave.dao.MenuDao;
import com.brave.thebrave.exception.runtime.common.NotificationRuntimeBrvException;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MenuService{

	protected Logger logger = LoggerFactory.getLogger(this.getClass());

	private final MenuDao menuDao;
	private final ContentService contentService;

	public List<MenuTreeListResponse> getMenuTreeList(String langType){
		langType = "KR".equals(langType) ? "KOR" : langType;
		return menuDao.getMenuTreeList(langType);
	}
	
	public List<MenuListResponse> getList(Integer menu_seq){
		return menuDao.getList(menu_seq);
	}
	public List<MenuListResponse> getListUse(Integer menu_seq){
		return menuDao.getListUse(menu_seq);
	}
	public MenuVo selectMenuOne(Integer menu_seq){
		return menuDao.selectMenuOne(menu_seq);
	}

	public MenuVo selectMenuOneName(SelectMenuOneNameRequest request){
		return menuDao.selectMenuOneName(request);
	}

	public int saveMenu(MenuVo menuVo){
		return menuDao.saveMenu(menuVo);
	}

	public int updateMenu(MenuVo menuVo){
		return menuDao.updateMenu(menuVo);
	}

	public int selectMaxLevel(Integer parent){
		return menuDao.selectMaxLevel(parent);
	}

	public int saveMenuUpdateUseYN(MenuVo menuVo){
		return menuDao.saveMenuUpdateUseYN(menuVo);
	}

	public int deleteMenuData(Integer menu_seq){
		return menuDao.deleteMenuData(menu_seq);
	}

	/**
	 * Sub 메뉴 리스트
	 * @param parent
	 * @return
	 */
  	public List<MenuListResponse> getSubMenuList(Integer parent) {
		return menuDao.getSubMenuList(parent);
  }

	/**
	 * 메인 컨텐츠 저장
	 * @param mainContentsVo
	 * @return
	 */
	public int saveMainContents(MainContentsVo mainContentsVo) {
		  return menuDao.saveMainContents(mainContentsVo);
    }

	/**
	 * 메인 컨텐츠 조회
	 * @return
	 */
	public MainContentsResponse getMainContents() {
		return menuDao.getMainContents();
	}

	/**
	 * 메뉴 저장 프로세스
	 * @param menuVo
	 * @param menu_type
	 * @param langType
	 * @param contents
	 * @param contents2
	 * @param contents3
	 */
	@Transactional
    public void insertProcess(MenuVo menuVo, String menu_type, String langType, String contents, String contents2, String contents3) {

		// 메뉴 등록
		saveMenu(menuVo);

		// 컨텐츠 등록
		if (menu_type.equals("PAGE")) {

			ContentVo contentVo = new ContentVo();
			contentVo.setContents(contents);
			contentVo.setMenuSeq(String.valueOf(menuVo.getMenuSeq()));

			if (langType.equals("Ko")) {
				contentVo.setContents(contents);
			} else if (langType.equals("Eng")) {
				contentVo.setContentsEng(contents2);
			} else if (langType.equals("Cn")) {
				contentVo.setContentsVt(contents3);
			}

			contentVo.setLangType(langType);

			int cnt = contentService.saveContent(contentVo);

			if (cnt == 0) {
				throw new NotificationRuntimeBrvException("컨텐츠 저장에 실패하였습니다.");
			}
		}
    }

	/**
	 * 메뉴 수정 프로세스
	 * @param menuVo
	 * @param menu_seq
	 * @param menu_type
	 * @param langType
	 * @param contents
	 * @param contents2
	 * @param contents3
	 * @param category_seq
	 * @param link
	 * @param use_yn
	 */
	@Transactional
	public void updateProcess(MenuVo menuVo, Integer menu_seq, String menu_type, String langType, String contents, String contents2, String contents3, Integer category_seq, String link, String use_yn) {

		if (menu_type.equals("PAGE")) {

			ContentVo contentVo = new ContentVo();
			contentVo.setMenuSeq(String.valueOf(menu_seq));
			contentVo.setLangType(langType);

			if (langType.equals("Ko")) {
				contentVo.setContents(contents);
			} else if (langType.equals("Eng")) {
				contentVo.setContentsEng(contents2);
			} else if (langType.equals("Cn")) {
				contentVo.setContentsVt(contents3);
			}

			// 컨텐츠 등록 여부 체크
			ContentVo vo = contentService.isContentsExisting(contentVo);

			// 컨텐츠 히스토리 등록 여부 체크
			ContentVo hisvo = contentService.isHistoryContentsExisting(contentVo);

			int procCnt = 0;
			int histCnt = 0;

			ContentsHistoryVo historyVo = new ContentsHistoryVo();

			if (vo != null) { // 수정

				if (hisvo != null) {

					// 컨텐츠 히스토리 저장
					historyVo.setContentsSeq(vo.getContentsSeq().toString());
					if (langType.equals("Ko")) {
						historyVo.setContents(vo.getContents());
					} else if (langType.equals("Eng")) {
						historyVo.setContents(vo.getContentsEng());
					} else if (langType.equals("Cn")) {
						historyVo.setContents(vo.getContentsCn());
					}
					historyVo.setRegDate(vo.getRegDate());
					historyVo.setLangType(langType);

					histCnt = contentService.insertContentHistory(historyVo);

					if (histCnt == 0) {
						throw new NotificationRuntimeBrvException("컨텐츠 히스토리 저장에 실패하였습니다.");
					}
				}
				procCnt = contentService.updateContents(contentVo);
			} else {
				procCnt = contentService.insertContents(contentVo);
			}

			if (procCnt == 0) {
				throw new NotificationRuntimeBrvException("컨텐츠 저장에 실패하였습니다.");
			}

		} else if (menu_type.equals("BOARD")) {
			menuVo.setCategorySeq(category_seq);
		} else if (menu_type.equals("LINK")) {
			menuVo.setLink(link);
		}
		menuVo.setUseYn(use_yn);

		//메뉴등록
		updateMenu(menuVo);
	}

	/**
	 * 메뉴 기본정보 저장
	 * @param menuRequest
	 * @return
	 */
	public int saveMenuDefault(MenuRequest menuRequest) {
		return menuDao.saveMenuDefault(menuRequest);
	}

	/**
	 * 1Depth 메뉴만 조회
	 * @return
	 */
	public List<MenuListResponse> getOneDepthMenuList() {
		return menuDao.getOneDepthMenuList();
	}

	/**
	 * 선택된 메뉴의 하위 메뉴 리스트 조회
	 * @param menuSeq
	 * @return
	 */
	public List<MenuListResponse> childMenuList(String menuSeq) {
		return menuDao.childMenuList(menuSeq);
	}

	/**
	 * 관리자 페이지관리 메뉴트리
	 * @return
	 */
	public List<MenuTreeListResponse> getAdminMenuTreeList() {
		return menuDao.getAdminMenuTreeList();
	}

	@Transactional(value = "transactionManager", propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void contentsSaveProcess(MenuRequest menuRequest) {

		System.out.println("contents: " + menuRequest.getContents());
		// 컨텐츠 정보 저장
		ContentVo contentVo = new ContentVo();
		contentVo.setContents(menuRequest.getContents());
		contentVo.setMenuSeq(String.valueOf(menuRequest.getMenuSeq()));

		if (menuRequest.getLangType().equals("KOR")) {
			contentVo.setContents(menuRequest.getContents());
		} else if (menuRequest.getLangType().equals("ENG")) {
			contentVo.setContentsEng(menuRequest.getContents());
		}

		contentVo.setLangType(menuRequest.getLangType());

		ContentVo vo = contentService.isContentsExisting(contentVo);

		int cnt = 0;

		if (vo == null) {
			cnt = contentService.saveContent(contentVo);
		} else {
			cnt = contentService.updateContents(contentVo);
		}

		if (cnt == 0) {
			throw new NotificationRuntimeBrvException("컨텐츠 저장에 실패하였습니다.");
		}

		// 메뉴정보 업데이트
		int updateCnt = this.updateMenuDefault(menuRequest);

		if (updateCnt == 0) {
			throw new NotificationRuntimeBrvException("메뉴 수정 도중에 실패하였습니다.");
		}


	}

	/**
	 * 메뉴 기본정보 수정
	 * @param menuRequest
	 * @return
	 */
	public int updateMenuDefault(MenuRequest menuRequest) {
		return menuDao.updateMenuDefault(menuRequest);
	}

	/**
	 * 이동시킬 메뉴가 있는지 체크
	 * @param menuVo
	 * @return
	 */
	public int checkLevelMenu(MenuVo menuVo) {
		return menuDao.checkLevelMenu(menuVo);
	}

	/**
	 * 기존 레벨에 있는 메뉴 아래로 이동
	 * @param menuVo
	 */
	public void setMenuDirectionDown(MenuVo menuVo) {
		menuDao.setMenuDirectionDown(menuVo);
	}

	/**
	 * 타켓 메뉴 위로 이동
	 * @param menuVo
	 */
	public void setMenuDirectionUp(MenuVo menuVo) {
		menuDao.setMenuDirectionUp(menuVo);
	}

}