<%@ Control Language="c#" Inherits="AceSoft.RetailPlus.Reports.__AgentsCommisionReport" Codebehind="_agentscommisionreport.ascx.cs" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:UpdatePanel id="UpdatePanel1" runat="server">
<ContentTemplate>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td colspan="3"><img height="10" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="1"></td>
	</tr>
	<tr>
		<td><img src="/RetailPlus/_layouts/images/blank.gif" width="10" height="1" alt=""></td>
		<td>
			<table class="ms-toolbar" style="margin-left: 0px" cellpadding="2" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="ms-toolbar" >
						<table cellpadding="1" cellspacing="0" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap">
									<asp:imagebutton id="imgView" accesskey="V" tabIndex="1" height="16" width="16" border="0" ToolTip="View Report" ImageUrl="/RetailPlus/_layouts/images/tabpub.gif" runat="server" CssClass="ms-toolbar"></asp:imagebutton>
								</td>
								<td class="ms-toolbar" nowrap="nowrap"width="100">
									<asp:Label id="Label2" Runat="server">Report Options</asp:Label>
								</td>
								<td class="ms-toolbar" nowrap="nowrap">
									<asp:DropDownList id="cboReportOptions" runat="server" Width="150">
										<asp:ListItem Value="0" Selected="True">Web Format</asp:ListItem>
										<asp:ListItem Value="1">Acrobat PDF</asp:ListItem>
										<asp:ListItem Value="2">Microsoft Word</asp:ListItem>
										<asp:ListItem Value="3">Microsoft Excel</asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
						</table>
					</td>
					<td class="ms-toolbar" align="right" nowrap="nowrap"id="align01">
						<asp:UpdatePanel id="updPrint" runat="server">
                            <ContentTemplate>
						        <table cellspacing="0" cellpadding="0" width="100%" border="0">
							        <tr>
								        <td class="ms-toolbar" nowrap="nowrap" align="left">
									        <asp:Button id="cmdView" runat="server" Text="Go" onclick="cmdView_Click" OnClientClick="NewWindow();"></asp:Button>
								        </td>
							        </tr>
						        </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
					</td>
					<td class="ms-separator"><asp:label id="lblSeparator4" runat="server">|</asp:label></td>
					<td class="ms-toolbar">
						<table cellspacing="0" cellpadding="1" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap" style="width: 19px"><asp:imagebutton id="imgBack" accesskey="B" tabIndex="3" CssClass="ms-toolbar" runat="server" ImageUrl="/RetailPlus/_layouts/images/impitem.gif" alt="Back to previous window" border="0" width="16" height="16" CausesValidation="False" OnClick="imgBack_Click"></asp:imagebutton></td>
								<td nowrap="nowrap"><asp:linkbutton id="cmdBack" accesskey="B" tabIndex="4" CssClass="ms-toolbar" runat="server" CausesValidation="False" OnClick="cmdBack_Click">Back to previous window</asp:linkbutton></td>
							</tr>
						</table>
					</td>
					<td class="ms-toolbar" align="right" nowrap="nowrap"id="align032" width="99%" >
						<img src="/RetailPlus/_layouts/images/blank.gif" width="1" height="1" alt="">
					</td>
				</tr>
			</table>
			<asp:label id="lblReferrer" runat="server" visible="False"></asp:label>
		</td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="10"></td>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="ms-authoringcontrols" valign="top" style="PADDING-RIGHT:	10px; BORDER-TOP:	white 10px solid; PADDING-LEFT:	8px; padding-bottom:	10px" colspan="3">
						<table class="ms-authoringcontrols" style="MARGIN-BOTTOM: 5px" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td style="padding-bottom:2px" nowrap="nowrap">
									<label>Select Agent</label>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;&nbsp;</td>
								<td>
									<asp:DropDownList id="cboContactCode" runat="server" CssClass="ms-short"></asp:DropDownList>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
								<td style="padding-bottom:2px" nowrap="nowrap">
									<label>Select Report Type</label>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;&nbsp;</td>
								<td>
								    <asp:DropDownList id="cboReportType" runat="server" CssClass="ms-short"></asp:DropDownList>
								</td>
								<td width="99%" id="align02" nowrap="nowrap" align="right"><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="1">
								</td>
							</tr>
							<tr>
								<td style="padding-bottom:2px" nowrap="nowrap">
									<label>Select Department</label>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;&nbsp;</td>
								<td>
									<asp:DropDownList id="cboDepartment" runat="server" CssClass="ms-short"></asp:DropDownList>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
								<td style="padding-bottom:2px" nowrap="nowrap">
									<label>Select Position</label>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;&nbsp;</td>
								<td>
								    <asp:DropDownList id="cboPosition" runat="server" CssClass="ms-short"></asp:DropDownList>
								</td>
								<td width="99%" id="Td1" nowrap="nowrap" align="right"><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="1">
								</td>
							</tr>
							<tr>
								<td style="padding-bottom:2px" nowrap="nowrap">
									<label>Transaction Start &nbsp;Date</label>&nbsp;
								</td>
								<td class="ms-separator">&nbsp;&nbsp;&nbsp;</td>
								<td>
									<asp:TextBox id="txtStartTransactionDate" ondblclick="ontime(this)" accesskey="S" CssClass="ms-short" runat="server" BorderStyle="Groove" MaxLength="10" ToolTip="Double click to select date from Calendar" Width="72px"></asp:TextBox>
                                    <asp:TextBox id="txtStartTime" runat="server" AccessKey="I" BorderStyle="Groove"
                                        CssClass="ms-short" MaxLength="5" Width="46px">00:00</asp:TextBox>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
								<td style="padding-bottom:2px" nowrap="nowrap">
									<label>Transaction End Date</label>
								</td>
								<td class="ms-separator">&nbsp;&nbsp;&nbsp;</td>
								<td nowrap="nowrap">
									<asp:TextBox id="txtEndTransactionDate" ondblclick="ontime(this)" accesskey="E" CssClass="ms-short" runat="server" BorderStyle="Groove" MaxLength="10" ToolTip="Double click to select date from Calendar" Width="72px"></asp:TextBox>
                                    <asp:TextBox id="txtEndTime" runat="server" AccessKey="M" BorderStyle="Groove" CssClass="ms-short"
                                        MaxLength="5" Width="46px">23:59</asp:TextBox>
								</td>
								<td width="99%" id="align05" nowrap="nowrap" align="left">&nbsp;
									<asp:Label id="Label3" CssClass="ms-error" runat="server" Font-Names="Wingdings">l</asp:Label>
									<asp:Label id="Label4" CssClass="ms-error" runat="server"> Date must be in yyyy-mm-dd format.</asp:Label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="ms-sectionline" height="2"><img alt="" src="/RetailPlus/_layouts/images/empty.gif"></td>
				</tr>
				<tr>
					<td colspan="3" height="2" align="center">
					    <cr:crystalreportviewer id="CRViewer" runat="server" Width="350px" HasCrystalLogo="False" Height="50px" ToolPanelView="None" HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="false"  PrintMode="ActiveX" EnableParameterPrompt="False" ReuseParameterValuesOnRefresh="True"></cr:crystalreportviewer>        
					</td>
				</tr>
			</table>
		</td>
		<td><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="10"></td>
	</tr>
	<tr>
		<td colspan="3"><img height="10" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="1"></td>
	</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
