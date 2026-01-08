package com.brave.thebrave.dao;

import com.brave.thebrave.api.request.MenuRequest;
import com.brave.thebrave.api.request.SelectMenuOneNameRequest;
import com.brave.thebrave.api.response.MainContentsResponse;
import com.brave.thebrave.api.response.MenuListResponse;
import com.brave.thebrave.api.response.MenuTreeListResponse;
import com.brave.thebrave.api.vo.MainContentsVo;
import com.brave.thebrave.api.vo.MenuVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public class MenuDao{
	@Autowired
	SqlSession sqlSession;

	public List<MenuTreeListResponse> getMenuTreeList(String langType){return sqlSession.selectList("menu.menuTreeList", langType);}
	
	public List<MenuListResponse> getList(Integer menuSeq){
		return sqlSession.selectList("menu.getList", menuSeq);
	}

	public List<MenuListResponse> getListUse(Integer menuSeq){
		return sqlSession.selectList("menu.getListUse", menuSeq);
	}
	
	public MenuVo selectMenuOne(Integer menuSeq){
		return sqlSession.selectOne("menu.selectMenuOne",menuSeq);
	}
	public MenuVo selectMenuOneName(SelectMenuOneNameRequest request){
		return sqlSession.selectOne("menu.selectMenuOneName",request);
	}

	public int saveMenu(MenuVo menuVo){
		return sqlSession.insert("menu.saveMenu",menuVo);
	}

	public int updateMenu(MenuVo menuVo){
		return sqlSession.update("menu.updateMenu",menuVo);
	}

	public int selectMaxLevel(Integer parent){
		return sqlSession.selectOne("menu.selectMaxLevel",parent);
	}

	public int saveMenuUpdateUseYN(MenuVo menuVo){
		return sqlSession.update("menu.saveMenuUpdateUseYN", menuVo);
	}

	public int deleteMenuData(Integer menuSeq){ return sqlSession.delete("menu.deleteMenuData", menuSeq); }

	/**
	 * Sub 메뉴 리스트
	 * @param parent
	 * @return
	 */
	public List<MenuListResponse> getSubMenuList(Integer parent) {
		return sqlSession.selectList("menu.selectSubMenuList", parent);
	}

	/**
	 * 메인 컨텐츠 저장
	 * @param mainContentsVo
	 * @return
	 */
    public int saveMainContents(MainContentsVo mainContentsVo) {
		return sqlSession.update("menu.saveMainContents", mainContentsVo);
    }

	/**
	 * 메인 컨텐츠 조회
	 * @return
	 */
	public MainContentsResponse getMainContents() {
		return sqlSession.selectOne("menu.getMainContents");
	}

	/**
	 * 메뉴 기본정보 신규
	 * @param menuRequest
	 * @return
	 */
	public int saveMenuDefault(MenuRequest menuRequest) {
		return sqlSession.insert("menu.saveMenuDefault", menuRequest);
	}

	/**
	 * 1Depth 메뉴만 조회
	 * @return
	 */
	public List<MenuListResponse> getOneDepthMenuList() {
		return sqlSession.selectList("menu.getOneDepthMenuList");
	}

	/**
	 * 선택된 메뉴의 하위 메뉴 리스트 조회
	 * @param menuSeq
	 * @return
	 */
	public List<MenuListResponse> childMenuList(String menuSeq) {
		return sqlSession.selectList("menu.childMenuList", menuSeq);
	}

	/**
	 * 관리자 페이지관리 메뉴트리
	 * @return
	 */
	public List<MenuTreeListResponse> getAdminMenuTreeList() {
		return sqlSession.selectList("menu.adminMenuTreeList");
	}

	/**
	 * 메뉴 기본정보 수정
	 * @param menuRequest
	 * @return
	 */
	public int updateMenuDefault(MenuRequest menuRequest) {
		return sqlSession.update("menu.updateMenuDefault", menuRequest);
	}

	/**
	 * 이동시킬 메뉴가 있는지 체크
	 * @param menuVo
	 * @return
	 */
	public int checkLevelMenu(MenuVo menuVo) {
		return sqlSession.selectOne("menu.checkLevelMenu", menuVo);
	}

	/**
	 * 기존 레벨에 있는 메뉴 아래로 이동
	 * @param menuVo
	 */
	public void setMenuDirectionDown(MenuVo menuVo) {
		sqlSession.update("menu.setMenuDirectionDown", menuVo);
	}

	/**
	 * 타켓 메뉴 위로 이동
	 * @param menuVo
	 */
	public void setMenuDirectionUp(MenuVo menuVo) {
		sqlSession.update("menu.setMenuDirectionUp", menuVo);
	}

}
