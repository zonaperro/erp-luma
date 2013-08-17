<%@ Control Language="c#" Inherits="AceSoft.RetailPlus.Inventory._TransferIn.__Details" Codebehind="_Details.ascx.cs" %>
<script language="JavaScript" src="../../_Scripts/SelectAll.js"></script>
<script language="JavaScript" src="../../_Scripts/ConfirmDelete.js"></script>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td colSpan="3"><img height="10" alt="" src="../../_layouts/images/blank.gif" width="1" /></td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
		<td>
			<table class="ms-toolbar" style="MARGIN-LEFT: 0px" cellpadding="2" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="ms-toolbar">
                        <asp:UpdatePanel ID="updPrint" runat="server">
                            <ContentTemplate>
						        <table cellspacing="0" cellpadding="1" border="0">
							        <tr>
								        <td class="ms-toolbar" nowrap><asp:imagebutton id="imgPrint" title="Print this TransferIn Order" accessKey="G" tabIndex="5" height="16" width="16" border="0" alt="Print this TransferIn Order" ImageUrl="../../_layouts/images/edit.gif" runat="server" CssClass="ms-toolbar" OnClick="imgPrint_Click"></asp:imagebutton></td>
								        <td nowrap><asp:linkbutton id="cmdPrint" title="Print this TransferIn Order" accessKey="E" tabIndex="6" runat="server" CssClass="ms-toolbar" onclick="cmdPrint_Click">Print</asp:linkbutton></td>
							        </tr>
						        </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
					</td>
					<td class="ms-separator"><asp:label id="Label15" runat="server">|</asp:label></td>
			        <td class="ms-toolbar">
                        <asp:UpdatePanel ID="updPrintSellingPrice" runat="server">
                            <ContentTemplate>
				                <table cellspacing="0" cellpadding="1" border="0">
					                <tr>
						                <td class="ms-toolbar" nowrap><asp:imagebutton id="imgPrintSelling" ToolTip="Print this TransferIn Order Selling Price" accessKey="G" tabIndex="5" runat="server" CssClass="ms-toolbar" CausesValidation="False" ImageUrl="../../_layouts/images/print.gif" border="0" width="16" height="16" onclick="imgPrintSelling_Click" ></asp:imagebutton></td>
						                <td nowrap><asp:linkbutton id="cmdPrintSelling" ToolTip="Print this TransferIn Order Selling Price" accessKey="E" tabIndex="6" runat="server" CssClass="ms-toolbar" CausesValidation="False" onclick="cmdPrintSelling_Click">Print Selling Price</asp:linkbutton></td>
					                </tr>
				                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
			        </td>
					<td class="ms-separator"><asp:label id="Label12" runat="server">|</asp:label></td>
					<td class="ms-toolbar">
						<table cellspacing="0" cellpadding="1" border="0">
							<tr>
								<td class="ms-toolbar" nowrap><asp:imagebutton id="imgCancel" title="Back To TransferIn List" accessKey="C" tabIndex="3" height="16" width="16" border="0" alt="Back To TransferIn List" ImageUrl="../../_layouts/images/impitem.gif" runat="server" CssClass="ms-toolbar" CausesValidation="False" OnClick="imgCancel_Click"></asp:imagebutton></td>
								<td nowrap><asp:linkbutton id="cmdCancel" title="Back To TransferIn List" accessKey="C" tabIndex="4" runat="server" CssClass="ms-toolbar" CausesValidation="False" onclick="cmdCancel_Click">Back To TransferIn List</asp:linkbutton></td>
							</tr>
						</table>
					</td>
					<td class="ms-toolbar" id="align02" nowrap align="right" width="99%"><IMG height="1" alt="" src="../../_layouts/images/blank.gif" width="1">
					</td>
				</tr>
			</table>
		</td>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
		<td>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td class="ms-descriptiontext" colSpan="3"><asp:label id="lblTransferInID" runat="server" Visible="False"></asp:label>
						<asp:label id="lblReferrer" runat="server" Visible="False"></asp:label>
					</td>
				</tr>
				<tr>
					<td class="ms-sectionline" colSpan="3" height="1"><img alt="" src="../../_layouts/images/empty.gif" /></td>
				</tr>
				<tr>
					<td style="PADDING-BOTTOM: 10px" valign="top" colSpan="3">
						<table class="ms-authoringcontrols" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr style="PADDING-BOTTOM: 10px">
								<td class="ms-formspacer"></td>
								<td width="30%" rowSpan="4"><IMG alt="" src="../../_layouts/images/company_logo.gif"></td>
								<td class="ms-formspacer"></td>
								<td style="HEIGHT: 70px" borderColor="white" align="center" width="40%" rowSpan="3"><label class="ms-sectionheader" style="FONT-WEIGHT: bold; FONT-SIZE: 40px">TransferIn 
										Order</label></td>
								<td style="PADDING-BOTTOM: 2px" width="30%" colSpan="2"><label>TransferIn Order no:</label></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-formspacer"></td>
								<td class="ms-formspacer"></td>
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td style="PADDING-BOTTOM: 2px" width="30%"><asp:label id="lblTransferInNo" runat="server" CssClass="ms-error"></asp:label></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-formspacer" style="HEIGHT: 52px"></td>
								<td class="ms-formspacer" style="HEIGHT: 52px"></td>
								<td style="PADDING-BOTTOM: 2px; HEIGHT: 52px" valign="top" width="30%" colSpan="2"><label>Date 
										Prepared: </label>
									<asp:label id="lblTransferInDate" runat="server" CssClass="ms-error"></asp:label></td>
							</tr>
							<tr style="PADDING-BOTTOM: 20px">
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%" colSpan="2"><label>Supplier 
										Name:</label></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="40%" colSpan="2"><label>Contact:</label></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%" colSpan="2"><label>Terms:</label></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%"><asp:label id="lblSupplierID" runat="server" CssClass="ms-error" Visible="False"></asp:label>
									<asp:HyperLink id="lblSupplierCode" runat="server" Target="_blank">lblSupplierCode</asp:HyperLink></td>
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="40%"><asp:label id="lblSupplierContact" runat="server" CssClass="ms-error"></asp:label></td>
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%"><asp:label id="lblTerms" runat="server" CssClass="ms-error"></asp:label><asp:label id="lblModeOfterms" runat="server" CssClass="ms-error"></asp:label></td>
							</tr>
							<tr>
								<td class="ms-formspacer" colSpan="6"></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%" colSpan="2"><label>Supplier 
										Address:</label></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="40%" colSpan="2"><label>Telephone 
										no:</label></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%" colSpan="2"><label>Required 
										Delivery Date:</label></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%"><asp:label id="lblSupplierAddress" runat="server" CssClass="ms-error"></asp:label></td>
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="40%"><asp:label id="lblSupplierTelephoneNo" runat="server" CssClass="ms-error"></asp:label></td>
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%"><asp:label id="lblRequiredDeliveryDate" runat="server" CssClass="ms-error"></asp:label></td>
							</tr>
							<tr>
								<td class="ms-formspacer" colSpan="6"></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%" colSpan="2">
                                    <label>Transfer IN 
										to branch: (Specify complete address)</label></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="40%" colSpan="4"><label>Branch 
										Address:</label></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%"><asp:label id="lblBranchCode" runat="server" CssClass="ms-error"></asp:label><asp:label id="lblBranchID" runat="server" CssClass="ms-error" Visible="False"></asp:label></td>
								<td class="ms-formspacer"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="40%" colSpan="3"><asp:label id="lblBranchAddress" runat="server" CssClass="ms-error"></asp:label></td>
							</tr>
							<tr>
								<td class="ms-formspacer" colSpan="6"></td>
							</tr>
							<tr style="PADDING-BOTTOM: 5px">
								<td class="ms-authoringcontrols" style="PADDING-BOTTOM: 2px" width="30%" colSpan="6"><label>TransferIn 
										Remarks:</label><asp:label id="lblTransferInRemarks" runat="server" CssClass="ms-error"></asp:label></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="ms-sectionline" colSpan="3" height="1"><img alt="" src="../../_layouts/images/empty.gif" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
		<td><asp:datalist id="lstItem" runat="server" Width="100%" ShowFooter="False" CellPadding="0" OnItemDataBound="lstItem_ItemDataBound">
				<HeaderTemplate>
					<table width="100%" cellpadding="0" cellspacing="0" border="0" id="tblHeaderTemplate">
						<colgroup>
							<col width="10">
							<col width="20%">
							<col width="20%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
							<col width="10">
						</colgroup>
						<tr>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px">
							</TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px">
								<asp:hyperlink id="SortByDescription" runat="server">Description</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px">
								<asp:hyperlink id="SortByMatrixDescription" runat="server">Matrix Desc.</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px" align="right">
								<asp:hyperlink id="SortByQuantity" runat="server">Quantity</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px">
								<asp:hyperlink id="SortByProductUnitCode" runat="server">Unit of Measure</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px" align="right">
								<asp:hyperlink id="SortByUntCost" runat="server">Unit Cost</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px" align="right">
								<asp:hyperlink id="SortByDiscount" runat="server">Discount</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px" align="right">
								<asp:hyperlink id="SortByAmount" runat="server">Total Cost</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px; padding-top: 4px">
							</TH>
						</tr>
					</table>
				</HeaderTemplate>
				<ItemTemplate>
					<table id="tblItemTemplate" cellspacing="0" cellpadding="0" width="100%" border="0" onmouseover="this.bgColor='#FFE303'" onmouseout="this.bgColor='transparent'">
						<colgroup>
							<col width="10">
							<col width="20%">
							<col width="20%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
							<col width="12%">
							<col width="10">
						</colgroup>
						<tr>
							<td class="ms-vb-user">
								<input type="checkbox" id="chkList" runat="server" name="chkList" visible="false" />
							</td>
							<td class="ms-vb-user">
								<asp:HyperLink ID="lnkDescription" Runat="server"></asp:HyperLink>
							</td>
							<td class="ms-vb-user">
								<asp:HyperLink ID="lnkMatrixDescription" Runat="server"></asp:HyperLink>
							</td>
							<td class="ms-vb-user" align="right">
								<asp:Label ID="lblQuantity" Runat="server"></asp:Label>&nbsp;&nbsp;
							</td>
							<td class="ms-vb-user">
								<asp:Label ID="lblProductUnitID" Runat="server" Visible="False"></asp:Label>
								<asp:Label ID="lblProductUnitCode" Runat="server"></asp:Label>
							</td>
							<td class="ms-vb-user" align="right">
								<asp:Label ID="lblUnitCost" Runat="server"></asp:Label>
							</td>
							<td class="ms-vb-user" align="right">
								<asp:Label ID="lblDiscountApplied" Runat="server"></asp:Label>
								<asp:Label ID="lblPercent" Runat="server" Visible="False">%</asp:Label>
							</td>
							<td class="ms-vb-user" align="right">
								<asp:Label ID="lblAmount" Runat="server"></asp:Label>
							</td>
							<td class="ms-vb2">
								<A class="DropDown" id="anchorDown" href="" runat="server">
									<asp:Image id="divExpCollAsst_img" ImageUrl="../../_layouts/images/DLMAX.gif" runat="server" alt="Show"></asp:Image></A>
							</td>
						</tr>
						<tr>
							<td class="ms-vh2" height="1"><IMG height="5" alt="" src="../../_layouts/images/blank.gif" width="1"></td>
							<td colSpan="7" height="1">
								<div class="ACECollapsed" id="divExpCollAsst" runat="server" border="0">
									<asp:panel id="panItem" runat="server" Width="100%" Height="100%" CssClass="ms-authoringcontrols">
										<table id="tblpanItem" cellspacing="0" cellpadding="0" width="100%" border="0">
											<tr>
												<td class="ms-formspacer" colSpan="1"><IMG alt="" src="../../_layouts/images/trans.gif" width="10"></td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label4" CssClass="ms-vh2" runat="server" text="<b>VAT</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label7" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="20%">
													<asp:Label id="lblVAT" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
												<td width="19%">
													<asp:Label id="Label5" CssClass="ms-vh2" runat="server" text="<b>eVAT</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label9" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="40%">
													<asp:Label id="lblEVAT" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label6" CssClass="ms-vh2" runat="server" text="<b>Local Tax</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label11" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="20%">
													<asp:Label id="lblLocalTax" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
												<td width="19%">
													<asp:Label id="Label13" CssClass="ms-vh2" runat="server" text="<b></b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="lblisVATInclusive" CssClass="ms-vh2" runat="server" text="<b></b>"></asp:Label>
												</td>
												<td width="40%">
													<asp:Label id="Label15" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label8" CssClass="ms-vh2" runat="server" text="<b>Remarks</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label10" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td colspan="4">
													<asp:Label ID="lblRemarks" CssClass="ms-vb2" Runat="server"></asp:Label>
												</td>
											</tr>
										</table>
									</asp:panel></div>
							</td>
							<td class="ms-vh2" height="1"><IMG height="5" alt="" src="../../_layouts/images/blank.gif" width="1"></td>
						</tr>
					</table>
				</ItemTemplate>
			</asp:datalist></td>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
	</tr>
	<tr>
		<td colSpan="3"><img height="10" alt="" src="../../_layouts/images/blank.gif" width="1" /></td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
		<td>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td class="ms-sectionline" colSpan="3" height="1"><img alt="" src="../../_layouts/images/empty.gif" /></td>
				</tr>
				<tr>
					<td valign="top" colSpan="3">
						<table class="ms-authoringcontrols" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr style="PADDING-BOTTOM: 15px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label>   &nbsp; &nbsp; <b>Total Before Discount:</b></label></td>
				                <td align="right"><asp:label id="lblTotalDiscount1" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: auto">
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td align="left"><label>   &nbsp; &nbsp; Applicable Discount (1):</label></td>
				                <td align="right"><asp:textbox onkeypress="AllNum()" id="txtTransferInDiscountApplied" accessKey="" runat="server" CssClass="ms-short-disabled" BorderStyle="Groove" Text=0 Width="82px" ></asp:textbox><asp:dropdownlist id="cboTransferInDiscountType" runat="server" CssClass="ms-short-disabled" enabled="false">
                                    <asp:ListItem Value="0">NA</asp:ListItem>
                                    <asp:ListItem Value="1">amt</asp:ListItem>
                                    <asp:ListItem Selected="True" Value="2">%</asp:ListItem>
                                </asp:dropdownlist>
                                </td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 15px">
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td align="left"><label>   &nbsp; &nbsp; Subtotal Discount (1):</label></td>
				                <td align="right"><asp:label id="lblTransferInDiscount" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr>
				                <td></td>
				                <td></td>
				                <td class="ms-sectionline" colspan="2" height="1"><img alt="" src="../../_layouts/images/empty.gif" /></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 15px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label>   &nbsp; &nbsp; <b>Total Before Discount:</b></label></td>
				                <td align="right"><asp:label id="lblTotalDiscount2" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: auto">
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td align="left"><label>   &nbsp; &nbsp; Applicable Discount (2):</label></td>
				                <td align="right"><asp:textbox onkeypress="AllNum()" id="txtTransferInDiscount2Applied" accessKey="" runat="server" CssClass="ms-short-disabled" BorderStyle="Groove" Text=0 Width="82px" ></asp:textbox><asp:dropdownlist id="cboTransferInDiscount2Type" runat="server" CssClass="ms-short-disabled" enabled="false">
                                    <asp:ListItem Value="0">NA</asp:ListItem>
                                    <asp:ListItem Value="1">amt</asp:ListItem>
                                    <asp:ListItem Selected="True" Value="2">%</asp:ListItem>
                                </asp:dropdownlist>
                                </td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 15px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label>   &nbsp; &nbsp; Subtotal Discount (2):</b></label></td>
				                <td align="right"><asp:label id="lblTransferInDiscount2" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr>
				                <td></td>
				                <td></td>
				                <td class="ms-sectionline" colspan="2" height="1"><img alt="" src="../../_layouts/images/empty.gif" /></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 15px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label>   &nbsp; &nbsp; <b>Total Before Discount:</b></label></td>
				                <td align="right"><asp:label id="lblTotalDiscount3" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: auto">
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td align="left"><label>   &nbsp; &nbsp; Applicable Discount (3):</label></td>
				                <td align="right"><asp:textbox onkeypress="AllNum()" id="txtTransferInDiscount3Applied" accessKey="" runat="server" CssClass="ms-short-disabled" BorderStyle="Groove" Text=0 Width="82px" ></asp:textbox><asp:dropdownlist id="cboTransferInDiscount3Type" runat="server" CssClass="ms-short-disabled" enabled="false">
                                    <asp:ListItem Value="0">NA</asp:ListItem>
                                    <asp:ListItem Value="1">amt</asp:ListItem>
                                    <asp:ListItem Selected="True" Value="2">%</asp:ListItem>
                                </asp:dropdownlist></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 25px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label>   &nbsp; &nbsp; Subtotal Discount (3):</label></td>
				                <td align="right"><asp:label id="lblTransferInDiscount3" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr>
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td class="ms-sectionline" colSpan="2" height="1"><img alt="" src="../../_layouts/images/empty.gif" /></td>
			                </tr>
			                <tr style="PADDING-TOP: 5px;PADDING-BOTTOM: 5px">
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td align="left"><label><b>VATable Amount:</b></label><asp:CheckBox ID="chkIsVatInclusive" runat="server" Checked="true" Text="(Is-Vat-Inclusive)" enabled=false/></td>
				                <td align="right"><asp:label id="lblTransferInVatableAmount" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 5px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label><b>Subtotal:</b></label></td>
				                <td align="right"><asp:label id="lblTransferInSubTotal" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 5px">
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td align="left"><label><b>VAT:</b></label></td>
				                <td align="right"><asp:label id="lblTransferInVAT" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 5px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label><b>Freight:</b></label></td>
				                <td align="right"><asp:textbox onkeypress="AllNum()" id="txtTransferInFreight" accessKey="" runat="server" CssClass="ms-short-disabled" BorderStyle="Groove" Text="0.00" ></asp:textbox></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 5px">
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td align="left"><label><b>TransferIn Deposit:</b></label></td>
				                <td align="right"><asp:textbox onkeypress="AllNum()" id="txtTransferInDeposit" accessKey="" runat="server" CssClass="ms-short-disabled" BorderStyle="Groove" Text="0.00" ></asp:textbox></td>
			                </tr>
			                <tr>
				                <td class="ms-formspacer"></td>
				                <td></td>
				                <td class="ms-sectionline" colSpan="2" height="1"><img alt="" src="../../_layouts/images/empty.gif" /></td>
			                </tr>
			                <tr style="PADDING-BOTTOM: 5px">
				                <td class="ms-formspacer"></td>
				                <td width="50%"></td>
				                <td align="left"><label><b>Total:</b></label></td>
				                <td align="right"><asp:label id="lblTransferInTotal" runat="server" CssClass="ms-error">0.00</asp:label></td>
			                </tr>
		                </table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
