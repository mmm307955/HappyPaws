package com.happypaws.vo;

public class ProductPagingVO {
	private int btnCur = 1; 
	private int btnFirst; 
	private int btnLast; 
	private int btnTotalCount; 
	private int btnCurTotal = 5;  
	private int rowTotalCount; 
	private int rowSizePerPage = 9; 
	private int rowFirst; 
	private int rowLast;

	public ProductPagingVO() {}
	
	public ProductPagingVO(ProductPagingVO pv) {
		// 값 설정
		this.btnCur = pv.getBtnCur();
		this.btnCurTotal = pv.getBtnCurTotal();
		this.rowTotalCount = pv.getRowTotalCount();
		this.rowSizePerPage = pv.getRowSizePerPage();
		
		// 계산 처리
		this.btnTotalCount = (this.rowTotalCount - 1) / this.rowSizePerPage + 1;
		this.btnFirst = this.btnCur - 2;
		this.btnLast = this.btnCur + 2; 
		this.rowFirst = (this.btnCur - 1) * this.rowSizePerPage + 1;
		this.rowLast = this.rowFirst + this.rowSizePerPage - 1;
		
		// 조건 처리
		if (this.rowLast > this.rowTotalCount) {
			this.rowLast = this.rowTotalCount;
		}
		
		if (this.btnLast > this.btnTotalCount) { 
			this.btnLast = this.btnTotalCount;
			this.btnFirst = this.btnCur - 3;
			
			if (this.btnCur == this.btnTotalCount) {
				this.btnFirst = this.btnCur - 4;
			}
		}
		
		if (this.btnCur - 2 <= 0) {
			this.btnFirst = 1;
			this.btnLast = Math.min(this.btnCurTotal, this.btnTotalCount);
		}
		
		if (this.rowFirst == 1) {
			this.rowFirst = 0;
		}
	}

	public int getBtnCur() {
		return btnCur;
	}

	public void setBtnCur(int btnCur) {
		this.btnCur = btnCur;
	}

	public int getBtnFirst() {
		return btnFirst;
	}

	public void setBtnFirst(int btnFirst) {
		this.btnFirst = btnFirst;
	}

	public int getBtnLast() {
		return btnLast;
	}

	public void setBtnLast(int btnLast) {
		this.btnLast = btnLast;
	}

	public int getBtnTotalCount() {
		return btnTotalCount;
	}

	public void setBtnTotalCount(int btnTotalCount) {
		this.btnTotalCount = btnTotalCount;
	}

	public int getBtnCurTotal() {
		return btnCurTotal;
	}

	public void setBtnCurTotal(int btnCurTotal) {
		this.btnCurTotal = btnCurTotal;
	}

	public int getRowTotalCount() {
		return rowTotalCount;
	}

	public void setRowTotalCount(int rowTotalCount) {
		this.rowTotalCount = rowTotalCount;
	}

	public int getRowSizePerPage() {
		return rowSizePerPage;
	}

	public void setRowSizePerPage(int rowSizePerPage) {
		this.rowSizePerPage = rowSizePerPage;
	}

	public int getRowFirst() {
		return rowFirst;
	}

	public void setRowFirst(int rowFirst) {
		this.rowFirst = rowFirst;
	}

	public int getRowLast() {
		return rowLast;
	}

	public void setRowLast(int rowLast) {
		this.rowLast = rowLast;
	}
}