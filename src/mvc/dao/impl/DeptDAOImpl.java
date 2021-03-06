package mvc.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import mvc.dao.IDeptDAO;
import mvc.dao.util.AbstractDAOImpl;
import mvc.util.MathUtil;
import mvc.vo.Dept;

public class DeptDAOImpl extends AbstractDAOImpl implements IDeptDAO {
	private PreparedStatement pstmt;
	public DeptDAOImpl (Connection conn){
		super(conn) ;
	}

	@Override
	public boolean doCreate(Dept vo) throws Exception {
		String sql = "INSERT INTO dept(deptno,dname,loc) VALUES(?,?,?)";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, vo.getDeptno());
		this.pstmt.setString(2, vo.getDname());
		this.pstmt.setString(3, vo.getLoc());
		return this.pstmt.executeUpdate() >0;
	}

	@Override
	public boolean doUpdate(Dept vo) throws Exception {
		String sql = "UPDATE dept Set dname=?,loc=? WHERE deptno=?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setString(1, vo.getDname());
		this.pstmt.setString(2,vo.getLoc());
		this.pstmt.setInt(3, vo.getDeptno());
		return this.pstmt.executeUpdate() > 0 ;
	}
	
	@Override
	public boolean doRemoveBatch(Set<Integer> ids) throws Exception {
		return super.removeHandle(ids,"dept","deptno");
	}
	@Override
	public Dept findById(Integer id) throws Exception {
		Dept vo = null;
		String sql = "SELECT deptno,dname,loc FROM dept WHERE deptno=?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, id);
		ResultSet rs = this.pstmt.executeQuery();
		if(rs.next()){
			vo = new Dept();
			vo.setDeptno(rs.getInt(1));
			vo.setDname(rs.getString(2));
			vo.setLoc(rs.getString(3));
		}
		return vo;
	}

	@Override
	public List<Dept> findAll() throws Exception {
		List<Dept> all = new ArrayList<Dept>();
		String sql = "SELECT deptno,dname,loc FROM dept";
		this.pstmt = this.conn.prepareStatement(sql);
		ResultSet rs = this.pstmt.executeQuery();
		while(rs.next()){
			Dept vo = new Dept();
			vo.setDeptno(rs.getInt(1));
			vo.setDname(rs.getString(2));
			vo.setLoc(rs.getString(3));
			all.add(vo);
		}
		return all;
	}

	@Override
	public List<Dept> findAllSplit(Integer currentPage, Integer lineSize,
			String column, String keyWord) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getAllCount(String column, String keyWord) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Dept> findAllByStat() throws Exception {
		List<Dept> all = new ArrayList<Dept>();
		String sql = "SELECT d.deptno,d.dname,d.loc,temp.count,temp.sum,temp.avg,temp.max,temp.min FROM dept d,( "
				+ " SELECT deptno dno,COUNT(empno) count,SUM(sal) sum,AVG(sal) avg,MAX(sal) max,MIN(sal) min "
				+ " FROM emp GROUP BY deptno) temp WHERE d.deptno = temp.dno(+)";
		this.pstmt = super.conn.prepareStatement(sql);
		ResultSet rs = this.pstmt.executeQuery();
		while (rs.next()) {
			Dept vo = new Dept();
			vo.setDeptno(rs.getInt(1));
			vo.setDname(rs.getString(2));
			vo.setLoc(rs.getString(3));
			vo.setStat(new HashMap<String,Object>());
			vo.getStat().put("count",rs.getInt(4));
			vo.getStat().put("sum",rs.getDouble(5));
			vo.getStat().put("avg",MathUtil.round(rs.getDouble(6),2));
			vo.getStat().put("max",rs.getDouble(7));
			vo.getStat().put("min",rs.getDouble(8));
			all.add(vo);
		}
		return all;
	}

	@Override
	public Dept findByIdDetails(Integer id) throws Exception {
		Dept vo = null;
		String sql = "SELECT d.deptno,d.dname,d.loc,temp.count,temp.sum,temp.avg,temp.max,temp.min FROM dept d,( "
				+ " SELECT deptno dno,COUNT(empno) count,SUM(sal) sum,AVG(sal) avg,MAX(sal) max,MIN(sal) min "
				+ " FROM emp GROUP BY deptno) temp WHERE d.deptno = temp.dno(+) AND d.deptno=? ";
		this.pstmt = super.conn.prepareStatement(sql);
		this.pstmt.setInt(1,id);
		ResultSet rs = this.pstmt.executeQuery();
		while (rs.next()) {
			vo = new Dept();
			vo.setDeptno(rs.getInt(1));
			vo.setDname(rs.getString(2));
			vo.setLoc(rs.getString(3));
			vo.setStat(new HashMap<String,Object>());
			vo.getStat().put("count",rs.getInt(4));
			vo.getStat().put("sum",rs.getDouble(5));
			vo.getStat().put("avg",MathUtil.round(rs.getDouble(6),2));
			vo.getStat().put("max",rs.getDouble(7));
			vo.getStat().put("min",rs.getDouble(8));
		}
		return vo;
	}
}
