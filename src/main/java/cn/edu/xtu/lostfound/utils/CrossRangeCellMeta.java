package cn.edu.xtu.lostfound.utils;

/**
 * 跨行元素元数据
 *
 */
public class CrossRangeCellMeta {

    private int firstRowIndex;
    private int firstColIndex;
    private int rowSpan;// 跨越行数
    private int colSpan;// 跨越列数
    
	public CrossRangeCellMeta(int firstRowIndex, int firstColIndex, int rowSpan, int colSpan) {
		super();
		this.firstRowIndex = firstRowIndex;
		this.firstColIndex = firstColIndex;
		this.rowSpan = rowSpan;
		this.colSpan = colSpan;
	}

	public int getFirstRow() {
        return firstRowIndex;
    }

	public int getLastRow() {
        return firstRowIndex + rowSpan - 1;
    }

	public int getFirstCol() {
        return firstColIndex;
    }

	public int getLastCol() {
        return firstColIndex + colSpan - 1;
    }

	public int getColSpan(){
        return colSpan;
    }

}
