<%@ Control Language="c#" Inherits="AceSoft.RetailPlus.GeneralLedger._AccountCategory.__Update" Codebehind="_Update.ascx.cs" %>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td colspan="3"><img height="10" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="1" /></td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="10" /></td>
		<td>
			<table class="ms-toolbar" style="margin-left: 0px" cellpadding="2" cellspacing="0" border="0" width="100%">
				<tr>
					<td class="ms-toolbar">
						<table cellspacing="0" cellpadding="1" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgSave" title="Update Account Category" accessKey="S" tabIndex="1" height="16" width="16" border="0" alt="Update Account Category" ImageUrl="/RetailPlus/_layouts/images/saveitem.gif" runat="server" CssClass="ms-toolbar"></asp:imagebutton>&nbsp;
								</td>
								<td nowrap="nowrap"><asp:linkbutton id="cmdSave" title="Update Account Category" accessKey="S" tabIndex="2" runat="server" CssClass="ms-toolbar" onclick="cmdSave_Click">Save and New</asp:linkbutton></td>
							</tr>
						</table>
					</td>
					<td class="ms-separator">|</td>
					<td class="ms-toolbar">
						<table cellspacing="0" cellpadding="1" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgSaveBack" title="Update Account Category" accessKey="S" tabIndex="1" height="16" width="16" border="0" alt="Update Account Category" ImageUrl="/RetailPlus/_layouts/images/saveitem.gif" runat="server" CssClass="ms-toolbar"></asp:imagebutton>&nbsp;
								</td>
								<td nowrap="nowrap"><asp:linkbutton id="cmdSaveBack" title="Update Account Category" accessKey="S" tabIndex="2" runat="server" CssClass="ms-toolbar" onclick="cmdSaveBack_Click">Save and Back</asp:linkbutton></td>
							</tr>
						</table>
					</td>
					<td class="ms-separator">|</td>
					<td class="ms-toolbar">
						<table cellspacing="0" cellpadding="1" border="0">
							<tr>
								<td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgCancel" title="Cancel Updating Account Category" accessKey="C" tabIndex="3" height="16" width="16" border="0" alt="Cancel Updating Account Category" ImageUrl="/RetailPlus/_layouts/images/impitem.gif" runat="server" CssClass="ms-toolbar" CausesValidation="False"></asp:imagebutton></td>
								<td nowrap="nowrap"><asp:linkbutton id="cmdCancel" title="Cancel Updating Account Category" accessKey="C" tabIndex="4" runat="server" CssClass="ms-toolbar" CausesValidation="False" onclick="cmdCancel_Click">Cancel</asp:linkbutton></td>
							</tr>
						</table>
					</td>
					<td width="99%" class="ms-toolbar" id="align02" nowrap="nowrap" align="right"><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="1" />
					</td>
				</tr>
			</table>
			<asp:Label id="lblReferrer" runat="server" Visible="False"></asp:Label>
			<asp:Label id="lblAccountCategoryID" runat="server" Visible="False"></asp:Label>
		</td>
		<td><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="10" /></td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="10" /></td>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td colspan="3" class="ms-descriptiontext" style="padding-bottom: 10px; PADDING-TOP: 8px">
						<font color="red">*</font> Indicates a required field
					</td>
				</tr>
				<tr>
					<td style="padding-bottom: 20px" valign="top">
						<div class="ms-sectionheader" style="padding-bottom: 8px">Step 1: Account Summary 
							Information</div>
						<div class="ms-descriptiontext" style="padding-bottom: 10px">Choose account 
							summary.</div>
					</td>
					<td class="ms-colspace">&nbsp;</td>
					<td class="ms-authoringcontrols ms-formwidth" style="PADDING-RIGHT: 10px; BORDER-TOP: white 1px solid; PADDING-LEFT: 8px; padding-bottom: 20px" valign="top">
						<table class="ms-authoringcontrols" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td class="ms-formspacer"><img alt="" src="/RetailPlus/_layouts/images/trans.gif" width="10" /></td>
								<td class="ms-authoringcontrols" width="100%"><asp:dropdownlist id="cboAccountSummary" CssClass="ms-short" runat="server" AutoPostBack="false"></asp:dropdownlist>
									<asp:RequiredFieldValidator id="RequiredFieldValidator5" runat="server" CssClass="ms-error" ErrorMessage="'Account Summary' must not be left blank." Display="Dynamic" ControlToValidate="cboAccountSummary" ForeColor=" "></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="ms-sectionline" height="1">
						<A name="InputFormSection1"></A><img alt="" src="/RetailPlus/_layouts/images/empty.gif"></td>
				</tr>
				<tr>
					<td valign="top" style="padding-bottom: 20px">
						<div class="ms-sectionheader" style="padding-bottom: 8px">Step 2:&nbsp;Account 
							Category Information</div>
						<div class="ms-descriptiontext" style="padding-bottom:	10px">
							Enter the account category code.</div>
						<div class="ms-descriptiontext" style="padding-bottom:	10px">
							Enter the account category name.</div>
					</td>
					<td class="ms-colspace">&nbsp;</td>
					<td class="ms-authoringcontrols ms-formwidth" valign="top" style="PADDING-RIGHT:	10px; BORDER-TOP:	white 1px solid; PADDING-LEFT:	8px; padding-bottom:	20px">
						<table class="ms-authoringcontrols" style="MARGIN-BOTTOM: 5px" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Account Category Code<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="/RetailPlus/_layouts/images/trans.gif" width="10" /></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:TextBox id="txtAccountCategoryCode" runat="server" accesskey="C" CssClass="ms-short" MaxLength="30" BorderStyle="Groove"></asp:TextBox>
									<asp:requiredfieldvalidator id="Requiredfieldvalidator1" runat="server" CssClass="ms-error" ErrorMessage="'Account Category Code' must not be left blank." Display="Dynamic" ControlToValidate="txtAccountCategoryCode"></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Account Category Name<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="/RetailPlus/_layouts/images/trans.gif" width="10" /></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:TextBox id="txtAccountCategoryName" runat="server" accesskey="G" CssClass="ms-long" MaxLength="50" BorderStyle="Groove"></asp:TextBox>
									<asp:requiredfieldvalidator id="Requiredfieldvalidator2" runat="server" CssClass="ms-error" ErrorMessage="'Account Category Name' must not be left blank." Display="Dynamic" ControlToValidate="txtAccountCategoryName"></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="3" class="ms-sectionline" height="2"><img alt="" src="/RetailPlus/_layouts/images/empty.gif"></td>
	</tr>
	<tr>
		<td colspan="3"><img height="10" alt="" src="/RetailPlus/_layouts/images/blank.gif" width="1" /></td>
	</tr>
</table>
