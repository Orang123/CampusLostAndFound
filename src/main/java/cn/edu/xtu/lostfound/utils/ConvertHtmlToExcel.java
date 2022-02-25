package cn.edu.xtu.lostfound.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * 将html table 转成 excel
 *
 * 记录下来所占的行和列，然后填充合并
 */
public class ConvertHtmlToExcel {
	
	 /**
     * html表格转excel
     *
     * @param tableHtml 如
     *            <table>
     *            ..
     *            </table>
     * @return
     */
    public static HSSFWorkbook tableExportExcel(String tableHtml) {
    	//HSSF:Horrible Spread Sheet Format 糟糕的电子表格格式
        HSSFWorkbook wb = new HSSFWorkbook();// 创建一个Excel文件
        HSSFSheet sheet = wb.createSheet();// 创建一个Excel的Sheet

        HSSFCellStyle style = wb.createCellStyle();//  excel的格子单元样式
        style.setAlignment(HorizontalAlignment.CENTER);//HSSFCellStyle.ALIGN_CENTER是老板 新版是HorizontalAlignment.CENTER

        List<CrossRangeCellMeta> crossRowEleMetaLs = new ArrayList<>();//跨行元素元数据的List
        int rowIndex = 0;
        try {
            Document data = DocumentHelper.parseText(tableHtml);//解析html表格内容 解析为Document对象
            // 生成表头
            Element thead = data.getRootElement().element("thead");//获取<thead>标签 标题元素
            HSSFCellStyle titleStyle = getTitleStyle(wb);
            if (thead != null) {
                List<Element> trLs = thead.elements("tr");//获取tr标签内数据列表
                for (Element trEle : trLs) {//依次遍历每一行数据
                    HSSFRow row = sheet.createRow(rowIndex);//新创建excel的行
                    List<Element> thLs = trEle.elements("th");//取出tr中的所有列
                    makeRowCell(thLs, rowIndex, row, 0, titleStyle, crossRowEleMetaLs);
                    row.setHeightInPoints(17);
                    rowIndex++;
                }
            }
            // 生成表体
            Element tbody = data.getRootElement().element("tbody");
            if (tbody != null) {
                HSSFCellStyle contentStyle = getContentStyle(wb);
                List<Element> trLs = tbody.elements("tr");
                for (Element trEle : trLs) {
                    HSSFRow row = sheet.createRow(rowIndex);
//                    List<Element> thLs = trEle.elements("th");
//                    int cellIndex = makeRowCell(thLs, rowIndex, row, 0, titleStyle, crossRowEleMetaLs);
                    List<Element> tdLs = trEle.elements("td");
                    makeRowCell(tdLs, rowIndex, row, 0, contentStyle, crossRowEleMetaLs);
                    row.setHeightInPoints(18);
                    rowIndex++;
                }
            }
            // 合并表头
            for (CrossRangeCellMeta crcm : crossRowEleMetaLs) {
                sheet.addMergedRegion(new CellRangeAddress(crcm.getFirstRow(), crcm.getLastRow(), crcm.getFirstCol(), crcm.getLastCol()));
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        //自动调整列宽
        for (int i = 0; i < 15; i++) {
            sheet.autoSizeColumn((short)i);
        }
        return wb;
    }

    /**
     * 生产行内容
     *
     * @return 最后一列的cell index
     *
     * @param tdLs th或者td集合
     * @param rowIndex 行号
     * @param row POI行对象
     * @param startCellIndex
     * @param cellStyle 样式
     * @param crossRowEleMetaLs 跨行元数据集合
     * @return
     */
    private static int makeRowCell(List<Element> tdLs, int rowIndex, HSSFRow row, int startCellIndex, HSSFCellStyle cellStyle,
                                   List<CrossRangeCellMeta> crossRowEleMetaLs) {
        int i = startCellIndex;
        for (int eleIndex = 0; eleIndex < tdLs.size(); i++, eleIndex++) {
            int captureCellSize = getCaptureCellSize(rowIndex, i, crossRowEleMetaLs);
            while (captureCellSize > 0) {
                for (int j = 0; j < captureCellSize; j++) {// 当前行跨列处理（补单元格）
                    row.createCell(i);//使用此项在行中创建新单元格并返回它。
                    i++;
                }
                captureCellSize = getCaptureCellSize(rowIndex, i, crossRowEleMetaLs);
            }
            Element thEle = tdLs.get(eleIndex);
            String val = thEle.getTextTrim();//得到文本 修改空白为空格
            if (StringUtils.isBlank(val)) {//在校验一个String类型的变量是否为空时 三总情形 null "" "   "(空格字符串)
                Element e = thEle.element("a");//两个a标签相邻 不能获取到 e的值,此外如果没有a标签 有span标签也会获取到对应的值
                if (e != null) {
                    val = e.getTextTrim();//元素所含有的text内容，其中连续的空格被转化为单个空格
                }
            }
            HSSFCell c = row.createCell(i);
            if (NumberUtils.isNumber(val)) {//检查是否含有非法字符串 false表示含有
                c.setCellValue(Double.parseDouble(val));
                c.setCellType(CellType.NUMERIC);//使用CellType.NUMERIC代替HSSFCell.CELL_TYPE_NUMERIC
            } else {
                c.setCellValue(val);
            }
            c.setCellStyle(cellStyle);
            int rowSpan = NumberUtils.toInt(thEle.attributeValue("rowspan"), 1);
            int colSpan = NumberUtils.toInt(thEle.attributeValue("colspan"), 1);
            if (rowSpan > 1 || colSpan > 1) { // 存在跨行或跨列
                crossRowEleMetaLs.add(new CrossRangeCellMeta(rowIndex, i, rowSpan, colSpan));
            }
            if (colSpan > 1) {// 当前行跨列处理（补单元格）
                for (int j = 1; j < colSpan; j++) {
                    i++;
                    row.createCell(i);
                }
            }
        }
        return i;
    }

    /**
     * 获得因rowSpan占据的单元格
     *
     * @param rowIndex 行号
     * @param colIndex 列号
     * @param crossRowEleMetaLs 跨行列元数据
     * @return 当前行在某列需要占据单元格
     */
    private static int getCaptureCellSize(int rowIndex, int colIndex, List<CrossRangeCellMeta> crossRowEleMetaLs) {
        int captureCellSize = 0;
        for (CrossRangeCellMeta crossRangeCellMeta : crossRowEleMetaLs) {
            if (crossRangeCellMeta.getFirstRow() < rowIndex && crossRangeCellMeta.getLastRow() >= rowIndex) {
                if (crossRangeCellMeta.getFirstCol() <= colIndex && crossRangeCellMeta.getLastCol() >= colIndex) {
                    captureCellSize = crossRangeCellMeta.getLastCol() - colIndex + 1;
                }
            }
        }
        return captureCellSize;
    }

    /**
     * 获得标题样式
     *
     * @param workbook
     * @return
     */
    private static HSSFCellStyle getTitleStyle(HSSFWorkbook workbook) {
        short titleBackgroundColor = HSSFColor.HSSFColorPredefined.GREY_25_PERCENT.getIndex();
        short fontSize = 12;
        String fontName = "宋体";
        HSSFCellStyle style = workbook.createCellStyle();//单元格我的样式
        style.setVerticalAlignment(VerticalAlignment.CENTER);//新版将HSSFCellStyle.VERTICAL_CENTER改动为VerticalAlignment.CENTER 设置标题垂直居中
        style.setAlignment(HorizontalAlignment.CENTER);//设置标题水平居中
        style.setBorderBottom(BorderStyle.valueOf((short)1));//设置下边框样式 是单边框
        style.setBorderTop(BorderStyle.valueOf((short)1));//设置上边框样式 是单边框
        style.setBorderLeft(BorderStyle.valueOf((short)1));//设置左边框样式 是单边框
        style.setBorderRight(BorderStyle.valueOf((short)1));//设置右边框样式 是单边框
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);//新版本将HSSFCellStyle.SOLID_FOREGROUND换成FillPatternType.SOLID_FOREGROUND  设置图案的样式
        style.setFillForegroundColor(titleBackgroundColor);// 背景色
        HSSFFont font = workbook.createFont();
        font.setFontName(fontName);//设置字体类型
        font.setFontHeightInPoints(fontSize);//设置字体尺寸
        font.setBold(true);//HSSFFont.BOLDWEIGHT_BOLD 修改为true setBold(true) FontRecord.BOLDWEIGHT_BOLD即可 是否加粗
        style.setFont(font);//为此单元格设置此字体样式
        return style;
    }

    /**
     * 获得内容样式
     *
     * @param wb
     * @return
     */
    private static HSSFCellStyle getContentStyle(HSSFWorkbook wb) {
        short fontSize = 12;
        String fontName = "宋体";
        HSSFCellStyle style = wb.createCellStyle();
        style.setVerticalAlignment(VerticalAlignment.CENTER); 
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setBorderBottom(BorderStyle.valueOf((short)1));
        style.setBorderTop(BorderStyle.valueOf((short)1));
        style.setBorderLeft(BorderStyle.valueOf((short)1));
        style.setBorderRight(BorderStyle.valueOf((short)1));
        HSSFFont font = wb.createFont();
        font.setFontName(fontName);
        font.setFontHeightInPoints(fontSize);
        style.setFont(font);
        return style;
    }

}
