<%@ Control Language="c#" Inherits="AceSoft.RetailPlus.MasterFiles._Product.__ChangePrice" Codebehind="_changeprice.ascx.cs" %>
<script language="JavaScript" src="../../_Scripts/DocumentScripts.js"></script>
<script language="JavaScript" src="../../_Scripts/ComputeMargin.js"></script>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td colspan="3"><img height="10" alt="" src="../../_layouts/images/blank.gif" width="1"/></td>
	</tr>
	<tr>
		<td colspan="3" class="ms-sectionline" height="2"><img alt="" src="../../_layouts/images/blank.gif" /></td>
	</tr>
	<tr>
        <td class="ms-sectionline" colspan="3" height="1"><asp:Label ID="lblReferrer" runat="server" Visible="False"></asp:Label></td>
    </tr>
    <tr>
        <td class="ms-authoringcontrols" style="PADDING-RIGHT: 10px; BORDER-TOP: white 1px solid; PADDING-LEFT: 8px; padding-bottom: 20px" valign="top" colspan="3">
            <table class="ms-authoringcontrols" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" /></td>
	                <td class="ms-authoringcontrols" style="padding-bottom: 2px; PADDING-TOP: 10px" colspan="3">
                        <table class="ms-authoringcontrols" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td nowrap="nowrap"><label>Select Product Code<font color="red">*</font></label>
                                    <asp:label id="lblProductID" runat="server" Visible="False">0</asp:label>
                                    <asp:label id="lblProductSubGroupID" runat="server" Visible="False">0</asp:label>
                                </td>
                                <td> : </td>
                                <td nowrap="nowrap">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" >
                                        <ContentTemplate >
                                            <asp:DropDownList ID="cboProductCode" runat="server" AutoPostBack="True" CssClass="ms-long" OnSelectedIndexChanged="cboProductCode_SelectedIndexChanged"> </asp:DropDownList>
                                            <asp:TextBox ID="txtProductCode" runat="server" AccessKey="C" BorderStyle="Groove" CssClass="ms-short" style="min-width: 250px"></asp:TextBox>
                                            <asp:requiredfieldvalidator id="Requiredfieldvalidator1" runat="server" CssClass="ms-error" ErrorMessage="'Product code' must not be left blank." Display="Dynamic" ControlToValidate="cboProductCode"></asp:requiredfieldvalidator>
                                            <asp:ImageButton ID="cmdProductCode" runat="server" ImageUrl="../../_layouts/images/SPSSearch2.gif" ToolTip="Execute search" CausesValidation="False" Style="cursor: hand" OnClick="cmdProductCode_Click" />
                                            <asp:ImageButton id="imgProductHistory" runat="server" visible="false" ImageUrl="../../_layouts/images/prodhist.gif" ToolTip="Show product inventory history report" CausesValidation="false" Style="cursor: hand" OnClick="imgProductHistory_Click" OnClientClick="NewWindow();"></asp:ImageButton>
                                            <asp:ImageButton id="imgProductPriceHistory" runat="server" visible="false" ImageUrl="../../_layouts/images/pricehist.gif" ToolTip="Show product price history report" CausesValidation="false" Style="cursor: hand" OnClick="imgProductPriceHistory_Click" OnClientClick="NewWindow();"></asp:ImageButton>
                                            <asp:ImageButton id="imgInventoryAdjustment" runat="server" visible="false" ImageUrl="../../_layouts/images/invadj.gif" ToolTip="Adjust inventory count" CausesValidation="false" Style="cursor: hand" OnClick="imgInventoryAdjustment_Click" OnClientClick="NewWindow();"></asp:ImageButton>
                                            <asp:ImageButton id="imgEditNow" runat="server" visible="false" ImageUrl="../../_layouts/images/edit.gif" ToolTip="Edit this product" CausesValidation="false" Style="cursor: hand" OnClick="imgEditNow_Click" OnClientClick="NewWindow();"></asp:ImageButton>

                                            <asp:HyperLink id="lnkPackage" runat="server" visible="false" ToolTip="Setup Product Packages" Font-Underline="true" Target="_blank" CausesValidation="false" >&nbsp;p&nbsp;</asp:HyperLink>
                                            <asp:ImageButton id="imgVariationsMatrix" runat="server" visible="false" ImageUrl="../../_layouts/images/varmatrix.gif" ToolTip="Show Variations Matrix" CommandName="imgVariationsMatrixClick" CausesValidation="false" OnClick="imgVariationsMatrix_Click" OnClientClick="NewWindow();"></asp:ImageButton>
                                            <asp:ImageButton id="imgUnitsMatrix" runat="server" visible="false" ImageUrl="../../_layouts/images/unitmatrix.gif" ToolTip="Show Units Matrix" CommandName="imgUnitsMatrixClick" CausesValidation="false" OnClick="imgUnitsMatrix_Click"  OnClientClick="NewWindow();"></asp:ImageButton>
                                        </ContentTemplate>
                                        <Triggers> 
                                            <asp:AsyncPostBackTrigger ControlID="cboProductCode" Eventname="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="cmdProductCode" Eventname="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="imgSaveCopyToAllMatrix" Eventname="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="cmdSaveCopyToAllMatrix" Eventname="Click" />
                                        </Triggers> 
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </td>
	                <td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10" /></td>
                </tr>
                <tr>
	                <td class="ms-formspacer" colspan="5"></td>
                </tr>
                <tr>
	                <td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" /></td>
	                <td class="ms-authoringcontrols" style="padding-bottom: 2px" colspan="3">
	                    
	                    <asp:UpdatePanel ID="UpdatePanel5" runat="server" >
                            <ContentTemplate >
                                <asp:Label ID="lblProductPackage" Runat="server" Visible="False">Product Packages </asp:Label>
	                            <asp:hyperlink id="lnkProductPackageAdd" runat="server" ToolTip="Add new Package for this product." Visible="False">+</asp:hyperlink>
	                        </ContentTemplate>
                            <Triggers> 
                                <asp:AsyncPostBackTrigger ControlID="cboProductCode" Eventname="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="cmdProductCode" Eventname="Click" />
                                <asp:AsyncPostBackTrigger ControlID="imgSaveCopyToAllMatrix" Eventname="Click" />
                                <asp:AsyncPostBackTrigger ControlID="cmdSaveCopyToAllMatrix" Eventname="Click" />
                            </Triggers> 
                        </asp:UpdatePanel>
	                </td>
	                <td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10" /></td>
                </tr>
                <tr>
	                <td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" /></td>
	                <td colspan="3">
	                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
                            <ContentTemplate >
	                            <asp:datalist id="lstProductPackages" runat="server" Width="100%" ShowFooter="False" cellpadding="0" OnItemDataBound="lstProductPackages_ItemDataBound" OnItemCommand="lstProductPackages_ItemCommand">
		                            <HeaderTemplate>
			                            <table width="100%" cellpadding="0" cellspacing="0" border="0" id="tblHeaderTemplate">
				                            <colgroup>
                                                <col width="10">
					                            <col width="10">
					                            <col width="10">
					                            <col width="135px" align="left">
                                                <col width="90px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="150px" align="left">
                                                <col width="150px" align="left">
                                                <col width="150px" align="left">
					                            <col width="1%">
					                            <%--<col width="10">
					                            <col width="10">
					                            <col width="10">
					                            <col width="15%" align="left">
                                                <col width="9%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
                                                <col width="5%" align="left">
					                            <col width="1%">--%>
				                            </colgroup>
				                            <tr>
					                            <th class="ms-vh2" style="padding-bottom: 4px">&nbsp;&nbsp;&nbsp;</th>
						                        <th class="ms-vh2" style="padding-bottom: 4px">&nbsp;&nbsp;&nbsp;</th>
						                        <th class="ms-vh2" style="padding-bottom: 4px">&nbsp;&nbsp;&nbsp;</th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortByProductDesc" runat="server">Description</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortByUnit" runat="server">Unit</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortByQuantity" runat="server">Quantity</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortByPurchasePrice" runat="server">Purchase Price</asp:hyperlink></th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink4" runat="server">Retail %Margin</asp:hyperlink></th>
						                        <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink2" runat="server">Selling Price</asp:hyperlink></th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink3" runat="server">Level1 Price</asp:hyperlink></th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink6" runat="server">Level2 Price</asp:hyperlink></th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink7" runat="server">Level3 Price</asp:hyperlink></th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink8" runat="server">Level4 Price</asp:hyperlink></th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink9" runat="server">Level5 Price</asp:hyperlink></th>
                                                <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink1" runat="server">Wholesale %Margin</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortByPrice" runat="server">Selling Price</asp:hyperlink></th>
						                        <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="Hyperlink5" runat="server">%Comm</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortBarCode1" runat="server">BarCode1</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortBarCode2" runat="server">BarCode2</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
						                            <asp:hyperlink id="SortByBarCode3" runat="server">BarCode3</asp:hyperlink></th>
					                            <th class="ms-vh2" style="padding-bottom: 4px">
					                            </th>
				                            </tr>
			                            </table>
		                            </HeaderTemplate>
		                            <ItemTemplate>
			                            <table id="tblItemTemplate" cellspacing="0" cellpadding="0" width="100%" border="0" onmouseover="this.bgColor='#FFE303'" onmouseout="this.bgColor='transparent'">
				                            <colgroup>
					                            <col width="10">
					                            <col width="10">
					                            <col width="10">
					                            <col width="135px" align="left">
                                                <col width="90px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="75px" align="left">
                                                <col width="150px" align="left">
                                                <col width="150px" align="left">
                                                <col width="150px" align="left">
					                            <col width="1%">
				                            </colgroup>
				                            <tr>
					                            <td class="ms-vb-user" align="right">
						                            <input type="checkbox" id="chkProductPackageID" runat="server" name="chkProductPackageID" visible="false" />
						                            &nbsp;<asp:ImageButton id="cmdDelProductPackage" runat="server" ImageUrl="../../_layouts/images/delitem.gif" height="16" width="16" ToolTip="Delete this Package" Commandname="cmdDelProductPackage" CausesValidation="false"></asp:ImageButton>
					                            </td>
					                            <td class="ms-vb-user" align="right">
					                                <asp:ImageButton id="cmdPrintShelvesBarCode1" runat="server" ImageUrl="../../_layouts/images/print.gif" height="16" width="16" ToolTip="" Commandname="cmdPrintShelvesBarCode1" CausesValidation="false"></asp:ImageButton>
                                                    <asp:ImageButton id="cmdPrintShelvesBarCode2" runat="server" ImageUrl="../../_layouts/images/print.gif" height="16" width="16" ToolTip="" Commandname="cmdPrintShelvesBarCode2" CausesValidation="false"></asp:ImageButton>
                                                    <asp:ImageButton id="cmdPrintShelvesBarCode3" runat="server" ImageUrl="../../_layouts/images/print.gif" height="16" width="16" ToolTip="" Commandname="cmdPrintShelvesBarCode3" CausesValidation="false"></asp:ImageButton></td>
					                            <td class="ms-vb-user" align="right">
					                                <asp:ImageButton id="cmdPrintTagPriceBarCode1" runat="server" ImageUrl="../../_layouts/images/printtag.gif" height="16" width="16" ToolTip="" Commandname="cmdPrintTagPriceBarCode1" CausesValidation="false"></asp:ImageButton>
                                                    <asp:ImageButton id="cmdPrintTagPriceBarCode2" runat="server" ImageUrl="../../_layouts/images/printtag.gif" height="16" width="16" ToolTip="" Commandname="cmdPrintTagPriceBarCode2" CausesValidation="false"></asp:ImageButton>
                                                    <asp:ImageButton id="cmdPrintTagPriceBarCode3" runat="server" ImageUrl="../../_layouts/images/printtag.gif" height="16" width="16" ToolTip="" Commandname="cmdPrintTagPriceBarCode3" CausesValidation="false"></asp:ImageButton></td>
					                            <td class="ms-vb-user">
						                            <asp:Label ID="lblProductDesc" Runat="server"></asp:Label>
					                            </td>
                                                <td class="ms-vb-user" nowrap="nowrap">
					                                <asp:Label ID="lblProductPackageID" Runat="server" Visible="false"></asp:Label>
						                            <asp:Label ID="lblUnitName" Runat="server"></asp:Label>
					                            </td>
                                                <td class="ms-vb-user">
						                            <asp:TextBox accessKey="C" id="txtQuantity" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" Enabled="false" style="width:75px"></asp:TextBox>
					                            </td>
					                            <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtPurchasePrice" runat="server" onkeypress="AllNum()" onKeyUp="ChangePriceComputeMarginPP(this)" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0</asp:TextBox>
					                            </td>
                                                <td class="ms-vb-user">
                                                    <asp:TextBox accessKey="C" id="txtMargin" runat="server" onkeypress="AllNum()" onKeyUp="ChangePriceComputeMarginPP(this)" CssClass="ms-short-numeric" BorderStyle="Groove" BackColor="YellowGreen" style="width:75px">0</asp:TextBox>
                                                </td>
					                            <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtSellingPrice" runat="server" onkeypress="AllNum()" onKeyUp="ChangePriceComputeMarginByPricePP(this)" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0</asp:TextBox>
					                            </td>
                                                <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtPrice1" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0.00</asp:TextBox>
					                            </td>
                                                <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtPrice2" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0.00</asp:TextBox>
					                            </td>
                                                <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtPrice3" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0.00</asp:TextBox>
					                            </td>
                                                <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtPrice4" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0.00</asp:TextBox>
					                            </td>
                                                <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtPrice5" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0.00</asp:TextBox>
					                            </td>
                                                <td class="ms-vb-user">
                                                    <asp:TextBox accessKey="C" id="txtWSPriceMarkUp" runat="server" onkeypress="AllNum()" onKeyUp="ChangePriceComputeMarginPP(this)" CssClass="ms-short-numeric" BorderStyle="Groove" BackColor="YellowGreen" style="width:75px">0</asp:TextBox>
                                                </td>
					                            <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtWSPrice" runat="server" onkeypress="AllNum()" onKeyUp="ChangePriceComputeMarginByPricePP(this)" CssClass="ms-short-numeric" BorderStyle="Groove" style="width:75px">0</asp:TextBox>
					                            </td>
					                            <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtCommision" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" BackColor="Yellow" style="width:75px">0</asp:TextBox>
					                            </td>
					                            <td class="ms-vb-user">
					                                <asp:TextBox accessKey="C" id="txtBarCode1" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" MaxLength="15" style="width:100px"></asp:TextBox>
                                                    <asp:imagebutton id="imgCreateBarCode1" ToolTip="Generate EAN13 in-house barcode" accessKey="S" CssClass="ms-toolbar" runat="server" ImageUrl="../../_layouts/images/createbarcode.gif" alt="Generate EAN13 in-house barcode" border="0" width="16" height="16" CommandName="imgCreateBarCode1_Click" CausesValidation="False"></asp:imagebutton>
						                            <asp:Label id="lblVAT" runat="server" Visible="false"></asp:Label>
					                            </td>
					                            <td class="ms-vb-user">
						                            <asp:TextBox accessKey="C" id="txtBarCode2" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" MaxLength="15" style="width:100px"></asp:TextBox>
                                                    <asp:imagebutton id="imgCreateBarCode2" ToolTip="Generate EAN13 in-house barcode" accessKey="S" CssClass="ms-toolbar" runat="server" ImageUrl="../../_layouts/images/createbarcode.gif" alt="Generate EAN13 in-house barcode" border="0" width="16" height="16" CommandName="imgCreateBarCode2_Click" CausesValidation="False"></asp:imagebutton>
						                            <asp:Label id="lblEVAT" runat="server" Visible="false"></asp:Label>
					                            </td>
					                            <td class="ms-vb-user">
						                            <asp:TextBox accessKey="C" id="txtBarCode3" runat="server" onkeypress="AllNum()" CssClass="ms-short-numeric" BorderStyle="Groove" MaxLength="15" style="width:100px"></asp:TextBox>
                                                    <asp:imagebutton id="imgCreateBarCode3" ToolTip="Generate EAN13 in-house barcode" accessKey="S" CssClass="ms-toolbar" runat="server" ImageUrl="../../_layouts/images/createbarcode.gif" alt="Generate EAN13 in-house barcode" border="0" width="16" height="16" CommandName="imgCreateBarCode3_Click" CausesValidation="False"></asp:imagebutton>
						                            <asp:Label id="lblLocalTax" runat="server" Visible="false"></asp:Label>
					                            </td>
					                            <td class="ms-vb2"><A class="DropDown" id="anchorDown" href="" runat="server">
							                            <asp:Image id="divExpCollAsst_img" ImageUrl="../../_layouts/images/DLMAX.gif" runat="server" alt="Show" Visible="False"></asp:Image></A>
					                            </td>
				                            </tr>
			                            </table>
		                            </ItemTemplate>
	                            </asp:datalist>
	                            <asp:Label id="lblPurchasePriceHistory" runat="server" visible="false" CssClass="ms-error"></asp:Label>
	                        </ContentTemplate>
                            <Triggers> 
                                <asp:AsyncPostBackTrigger ControlID="cboProductCode" Eventname="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="cmdProductCode" Eventname="Click" />
                                <asp:AsyncPostBackTrigger ControlID="imgSaveCopyToAllMatrix" Eventname="Click" />
                                <asp:AsyncPostBackTrigger ControlID="cmdSaveCopyToAllMatrix" Eventname="Click" />
                            </Triggers> 
                        </asp:UpdatePanel>
	                </td>
	                <td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10" /></td>
                </tr>
                <tr>
	                <td class="ms-formspacer" colspan="5" style="height: 21px"></td>
                </tr>
            </table>
	            
        </td>
    </tr>
	<tr>
		<td colspan="3" class="ms-sectionline" height="2"><img alt="" src="../../_layouts/images/blank.gif" /></td>
	</tr>
	
	<tr>
		<td colspan="3"><img height="10" alt="" src="../../_layouts/images/blank.gif" width="1"/></td>
	</tr>
	<tr>
		<td class="ms-sectionline" colspan="3" height="1">
	        <table class="ms-toolbar" id="TABLE2" cellspacing="0" cellpadding="2" border="0" width="100%">
				<tr>
				    
		            <td class="ms-toolbar">
		                <table cellspacing="0" cellpadding="1" border="0">
			                <tr>
				                <td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgSaveCopyToAllMatrix" tooltip="Save product package prices" accessKey="N" tabIndex="1" height="16" width="16" border="0" ImageUrl="../../_layouts/images/saveitem.gif" runat="server" CssClass="ms-toolbar" OnClick="imgSaveCopyToAllMatrix_Click"></asp:imagebutton>&nbsp;
								</td>
								<td nowrap="nowrap"><asp:linkbutton id="cmdSaveCopyToAllMatrix" tooltip="Save product package pricess" accessKey="N" tabIndex="2" runat="server" CssClass="ms-toolbar" OnClick="cmdSaveCopyToAllMatrix_Click">Save product package prices</asp:linkbutton></td>
			                </tr>
		                </table>
	                </td>
                    <td class="ms-separator">|</td>
					<td class="ms-toolbar">
						<table cellspacing="0" cellpadding="1" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgCancel" title="Cancel Applying Local Tax" accessKey="C" tabIndex="3" CssClass="ms-toolbar" runat="server" ImageUrl="../../_layouts/images/impitem.gif" alt="Cancel Applying Local Tax" border="0" width="16" height="16" CausesValidation="False" OnClick="imgCancel_Click"></asp:imagebutton></td>
								<td nowrap="nowrap"><asp:linkbutton id="cmdCancel" title="Cancel Applying Local Tax" accessKey="C" tabIndex="4" CssClass="ms-toolbar" runat="server" CausesValidation="False" onclick="cmdCancel_Click">Cancel</asp:linkbutton></td>
							</tr>
						</table>
					</td>
					<td class="ms-toolbar" id="TD3" nowrap="nowrap" align="right" width="99%"></td>
					<td class="ms-toolbar" id="Td4" nowrap="nowrap" align="right"><img height="1" alt="" src="../../_layouts/images/blank.gif" width="1" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
