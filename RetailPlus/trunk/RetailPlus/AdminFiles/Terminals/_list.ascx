<%@ Control Language="c#" Inherits="AceSoft.RetailPlus.Security._Terminals.__List" Codebehind="_List.ascx.cs" %>
<script language="JavaScript" src="../../_Scripts/sExpCollapse.js"></script>
<script language="JavaScript" src="../../_Scripts/SelectAll.js"></script>
<script language="JavaScript" src="../../_Scripts/ConfirmDelete.js"></script>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td colspan="3"><img height="10" alt="" src="../../_layouts/images/blank.gif" width="1"/></td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
		<td>
			<table class="ms-toolbar" style="margin-left: 0px" cellpadding="2" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="ms-toolbar">
						<table cellspacing="0" cellpadding="1" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap"><%--<asp:imagebutton id="imgEdit" title="Update Selected Terminal" accessKey="E" tabIndex="5" CssClass="ms-toolbar" runat="server" ImageUrl="../../_layouts/images/edit.gif" alt="Update Selected Terminal" border="0" width="16" height="16" OnClick="imgEdit_Click"></asp:imagebutton>--%></td>
								<td nowrap="nowrap"><%--<asp:linkbutton id="cmdEdit" title="Update Selected Terminal" accessKey="E" tabIndex="6" CssClass="ms-toolbar" runat="server" onclick="cmdEdit_Click">Edit Selected Terminal</asp:linkbutton>--%></td>
							</tr>
						</table>
					</td>
					<td class="ms-toolbar" id="align01" nowrap="nowrap" align="right" width="99%">
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap" align="right"><asp:label id="lblDataCount1" CssClass="Normal" runat="server"> Go to page </asp:label><asp:dropdownlist id="cboCurrentPage" runat="server" AutoPostBack="True" onselectedindexchanged="cboCurrentPage_SelectedIndexChanged">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
									</asp:dropdownlist><asp:label id="lblDataCount" CssClass="class=ms-vb-user" runat="server"> of 0</asp:label></td>
							</tr>
						</table>
					</td>
					<td class="ms-toolbar" id="align02" nowrap="nowrap" align="right"><img height="1" alt="" src="../../_layouts/images/blank.gif" width="1" />
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
				<colgroup>
					<col width="1">
					<col width="25%">
					<col width="25%">
					<col width="50%">
				</colgroup>
				<tr>
					<th class="ms-vh2">
						<img height="10" alt="" src="../../_layouts/images/blank.gif" width="1"/></th>
					<th class="ms-vh2">
						<img height="5" alt="" src="../../_layouts/images/blank.gif" width="1"></th>
					<th class="ms-vh2">
						<img height="5" alt="" src="../../_layouts/images/blank.gif" width="1"></th>
					<th class="ms-vh2">
						<img height="5" alt="" src="../../_layouts/images/blank.gif" width="1"></th></tr>
				<tr>
					<td colspan="4" height="5"><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
				</tr>
			</table>
			<asp:datalist id="lstItem" runat="server" Width="100%" ShowFooter="False" CellPadding="0" OnItemDataBound="lstItem_ItemDataBound" OnItemCommand="lstItem_ItemCommand">
				<HeaderTemplate>
					<table width="100%" cellpadding="0" cellspacing="0" border="0" id="tblHeaderTemplate">
						<colgroup>
							<col width="10">
							<col width="10">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="20%">
							<col width="20%">
							<col width="14%">
							<col width="1%">
						</colgroup>
						<tr>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								&nbsp;&nbsp;&nbsp;</TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								&nbsp;&nbsp;&nbsp;</TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								<asp:hyperlink id="SortByTerminalNo" runat="server">Terminal No</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								<asp:hyperlink id="SortByTerminalCode" runat="server">Terminal Code</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								<asp:hyperlink id="SortByTerminalName" runat="server">Terminal Name</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								<asp:hyperlink id="SortByMachineSerialNo" runat="server">Machine Serial No.</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								<asp:hyperlink id="SortByAccreditationNo" runat="server">Accreditation No.</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
								<asp:hyperlink id="SortByStatus" runat="server">Status</asp:hyperlink></TH>
							<TH class="ms-vh2" style="padding-bottom: 4px">
							</TH>
						</tr>
					</table>
				</HeaderTemplate>
				<ItemTemplate>
					<table id="tblItemTemplate" cellspacing="0" cellpadding="0" width="100%" border="0" onmouseover="this.bgColor='#FFE303'" onmouseout="this.bgColor='transparent'">
						<COLGROUP>
							<COL align="center" width="10">
							<COL align="center" width="10">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="20%">
							<col width="20%">
							<col width="14%">
							<COL align="center" width="1%">
						</COLGROUP>
						<tr>
							<td class="ms-vb-user">
								<INPUT id="chkList" type="checkbox" name="chkList" runat="server" visible=false>
								&nbsp;
							</td>
							<td class="ms-vb2">
							    <asp:imagebutton id="imgItemEdit" CommandName="imgItemEdit" accessKey="U" tabIndex="1" height="16" width="16" border="0" tooltip="Update this terminal" ImageUrl="../../_layouts/images/edit.gif" runat="server" CssClass="ms-toolbar" ></asp:imagebutton>
						    </td>
							<td class="ms-vb-user">
								<asp:HyperLink id="lnkTerminalNo" Runat="server"></asp:HyperLink>
							<td class="ms-vb-user">
								<asp:HyperLink id="lnkTerminalCode" Runat="server"></asp:HyperLink>
							<td class="ms-vb-user">
								<asp:HyperLink id="lnkTerminalName" Runat="server"></asp:HyperLink></td>
							<td class="ms-vb2">
								<asp:HyperLink id="lnkMachineSerialNo" Runat="server"></asp:HyperLink></td>
							<td class="ms-vb2">
								<asp:HyperLink id="lnkAccreditationNo" Runat="server"></asp:HyperLink></td>
							<td class="ms-vb2">
								<asp:HyperLink id="lnkStatus" Runat="server"></asp:HyperLink></td>
							<td class="ms-vb2"><A class="DropDown" id="anchorDown" href="" runat="server">
									<asp:Image id="divExpCollAsst_img" ImageUrl="../../_layouts/images/DLMAX.gif" runat="server" alt="Show"></asp:Image></A>
							</td>
						</tr>
						<tr>
							<td class="ms-vh2" height="1"><img height="5" alt="" src="../../_layouts/images/blank.gif" width="1"></td>
							<td colspan="8" height="1">
								<DIV class="ACECollapsed" id="divExpCollAsst" runat="server" border="0">
									<asp:panel id="panCard" runat="server" Width="100%" Height="100%" CssClass="ms-authoringcontrols">
										<table id="tblPanCard" cellspacing="0" cellpadding="0" width="100%" border="0">
											<tr>
												<td class="ms-formspacer" colspan="1"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label1" CssClass="ms-vh2" runat="server" text="<b>Date Created</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label7" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="20%">
													<asp:Label id="lblDateCreated" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
												<td width="19%">
													<asp:Label id="Label4" CssClass="ms-vh2" runat="server" text="<b>Max Receipt Width</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label9" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="40%">
													<asp:Label id="lblMaxReceiptWidth" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label3" CssClass="ms-vh2" runat="server" text="<b>Printer Auto Cutter</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label11" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="20%">
													<asp:CheckBox id="chkIsPrinterAutoCutter" CssClass="ms-vb2" runat="server" Enabled="False"></asp:CheckBox>
												</td>
												<td width="19%">
													<asp:Label id="Label8" CssClass="ms-vh2" runat="server" text="<b>Auto Print</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label12" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="40%">
													<asp:CheckBox id="chkAutoPrint" CssClass="ms-vb2" runat="server" Enabled="False"></asp:CheckBox>
												</td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label2" CssClass="ms-vh2" runat="server" text="<b>Printer Name</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label13" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="20%">
													<asp:Label id="lblPrinterName" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
												<td width="19%">
													<asp:Label id="Label6" CssClass="ms-vh2" runat="server" text="<b>Cash Drawer Name</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label14" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="40%">
													<asp:Label id="lblCashDrawerName" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label5" CssClass="ms-vh2" runat="server" text="<b>Confirm Item Void</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label15" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="20%">
													<asp:CheckBox id="chkItemVoidConfirmation" CssClass="ms-vb2" runat="server" Enabled="False"></asp:CheckBox>
												</td>
												<td width="19%">
													<asp:Label id="Label10" CssClass="ms-vh2" runat="server" text="<b>Enable EVAT</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label16" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="40%">
													<asp:CheckBox id="chkEnableEVAT" CssClass="ms-vb2" runat="server" Enabled="False"></asp:CheckBox>
												</td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label19" CssClass="ms-vh2" runat="server" text="<b>Form Behavior</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label20" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td width="20%">
													<asp:Label id="lblFormBehavior" CssClass="ms-vh2" runat="server"></asp:Label>
												</td>
												<td width="19%">
												</td>
												<td width="1%">
												</td>
												<td width="40%">
												</td>
											</tr>
											<tr>
												<td width="19%">
													<asp:Label id="Label17" CssClass="ms-vh2" runat="server" text="<b>Marquee Message</b>"></asp:Label>
												</td>
												<td width="1%">
													<asp:Label id="Label18" CssClass="ms-vh2" runat="server" text="<b>:</b>"></asp:Label>
												</td>
												<td colspan="5">
													<asp:Label id="lblMarqueeMessage" CssClass="ms-vb2" runat="server"></asp:Label>
												</td>
											</tr>
										</table>
									</asp:panel></DIV>
							</td>
							<td class="ms-vh2" height="1"><img height="5" alt="" src="../../_layouts/images/blank.gif" width="1"></td>
						</tr>
					</table>
				</ItemTemplate>
			</asp:datalist></td>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
	</tr>
	<tr>
		<td colspan="3"><img height="10" alt="" src="../../_layouts/images/blank.gif" width="1"/></td>
	</tr>
</table>
