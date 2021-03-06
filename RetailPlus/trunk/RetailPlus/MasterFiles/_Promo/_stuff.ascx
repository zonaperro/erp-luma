<%@ Control Language="c#" Inherits="AceSoft.RetailPlus.MasterFiles._Promo.__Stuff" Codebehind="_Stuff.ascx.cs" %>
<script language="JavaScript" src="../../_Scripts/DocumentScripts.js"></script>
<script language="JavaScript" src="../../_Scripts/ConfirmDelete.js"></script>
<asp:UpdatePanel ID="UpdatePanel5" runat="server">
<ContentTemplate>
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
								<td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgCancel" title="Cancel Adding New Promo" accessKey="C" tabIndex="3" height="16" width="16" border="0" alt="Cancel Adding New Promo" ImageUrl="../../_layouts/images/impitem.gif" runat="server" CssClass="ms-toolbar" CausesValidation="False" OnClick="imgCancel_Click"></asp:imagebutton></td>
								<td nowrap="nowrap"><asp:linkbutton id="cmdCancel" title="Cancel Adding New Promo" accessKey="C" tabIndex="4" runat="server" CssClass="ms-toolbar" CausesValidation="False" onclick="cmdCancel_Click">Cancel</asp:linkbutton></td>
							</tr>
						</table>
					</td>
					<td width="99%" class="ms-toolbar" id="align04" nowrap="nowrap" align="right"><img height="1" alt="" src="../../_layouts/images/blank.gif" width="1" />
					</td>
				</tr>
			</table>
			<asp:Label id="lblReferrer" runat="server" Visible="False"></asp:Label>
			<asp:Label id="lblPromoID" runat="server" Visible="False"></asp:Label>
		</td>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
	</tr>
	<tr>
		<td><img height="1" alt="" src="../../_layouts/images/blank.gif" width="10" /></td>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td colspan="3" class="ms-descriptiontext" style="padding-bottom: 10px; PADDING-TOP: 8px">
						<font color="red">*</font> Indicates a required field
					</td>
				</tr>
				<tr>
					<td colspan="3" class="ms-sectionline" height="1"></td>
				</tr>
				<tr>
					<td valign="top" style="padding-bottom: 20px">
						<div class="ms-sectionheader" style="padding-bottom: 8px">Step 1:&nbsp;Promo 
							General Information</div>
						<div class="ms-descriptiontext" style="padding-bottom:	20px">
							Promo information in which you will add promotional items.</div>
					</td>
					<td class="ms-colspace">&nbsp;</td>
					<td class="ms-authoringcontrols ms-formwidth" valign="top" style="PADDING-RIGHT:	10px; BORDER-TOP:	white 1px solid; PADDING-LEFT:	8px; padding-bottom:	20px">
						<table class="ms-authoringcontrols" style="MARGIN-BOTTOM: 5px" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px">
									<label>Promo Code<font color="blue">:</font></label>
								</td>
								<td class="ms-authoringcontrols" width="100%">&nbsp;
									<asp:TextBox id="txtPromoCode" runat="server" accesskey="G" CssClass="ms-long-disabled" MaxLength="60" BorderStyle="Groove" ReadOnly="True"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px">
									<label>Promo&nbsp;Name<font color="blue">:</font></label>
								</td>
								<td class="ms-authoringcontrols" width="100%">&nbsp;
									<asp:TextBox id="txtPromoName" runat="server" accesskey="G" CssClass="ms-long-disabled" MaxLength="75" BorderStyle="Groove" ReadOnly="True"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px">
									<label>Promo&nbsp;Type<font color="blue">:</font></label>
								</td>
								<td class="ms-authoringcontrols" width="100%">&nbsp;
									<asp:TextBox id="txtPromoType" runat="server" accesskey="G" CssClass="ms-long-disabled" MaxLength="75" BorderStyle="Groove" ReadOnly="True"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px">
									<label>Start Date<font color="blue">:</font></label>
								</td>
								<td class="ms-authoringcontrols" width="100%">&nbsp;
									<asp:TextBox id="txtStartDate" runat="server" accesskey="G" CssClass="ms-long-disabled" MaxLength="20" BorderStyle="Groove" ReadOnly="True"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px">
									<label>End Date<font color="blue">:</font></label>
								</td>
								<td class="ms-authoringcontrols" width="100%">&nbsp;
									<asp:TextBox id="txtEndDate" runat="server" accesskey="G" CssClass="ms-long-disabled" MaxLength="20" BorderStyle="Groove" ReadOnly="True"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="ms-sectionline" height="1"></td>
				</tr>
				<tr>
					<td valign="top" style="padding-bottom: 20px">
						<div class="ms-sectionheader" style="padding-bottom: 8px">Step 2:&nbsp;Customer 
							Information</div>
						<div class="ms-descriptiontext" style="padding-bottom:	20px">
							Select contact(s) to be affected by the promo.</div>
					</td>
					<td class="ms-colspace">&nbsp;</td>
					<td class="ms-authoringcontrols ms-formwidth" valign="top" style="PADDING-RIGHT:	10px; BORDER-TOP:	white 1px solid; PADDING-LEFT:	8px; padding-bottom:	20px">
						<table class="ms-authoringcontrols" style="MARGIN-BOTTOM: 5px" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Select contact<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:dropdownlist id="cboContact" CssClass="ms-long" Width="60%" runat="server"></asp:dropdownlist>
                                    <asp:textbox id="txtContactCode" accessKey="C" runat="server" CssClass="ms-short" Width="30%" BorderStyle="Groove" MaxLength="30" ></asp:textbox>
                                    <asp:imagebutton id="imgContactCodeSearch" ToolTip="Execute search" 
                                        style="CURSOR: hand; width: 16px;" accessKey="P" 
                                        ImageUrl="../../_layouts/images/SPSSearch2.gif" runat="server" 
                                        CausesValidation="False" onclick="imgContactCodeSearch_Click"></asp:imagebutton>
									<asp:requiredfieldvalidator id="Requiredfieldvalidator4" runat="server" CssClass="ms-error" ErrorMessage="'Contacts' must not be left blank." Display="Dynamic" ControlToValidate="cboContact" ForeColor=" "></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="ms-sectionline" height="1"></td>
				</tr>
				<tr>
					<td valign="top" style="padding-bottom: 20px">
						<div class="ms-sectionheader" style="padding-bottom: 8px">Step 3:&nbsp;Product 
							Information</div>
						<div class="ms-descriptiontext" style="padding-bottom:	20px">
							Select products that will be affected of the promotion.</div>
						<div class="ms-descriptiontext" style="padding-bottom:	30px">
							Promotion can be applied to product group, sub&nbsp;group, product and up to 
							product variation.</div>
					</td>
					<td class="ms-colspace">&nbsp;</td>
					<td class="ms-authoringcontrols ms-formwidth" valign="top" style="PADDING-RIGHT:	10px; BORDER-TOP:	white 1px solid; PADDING-LEFT:	8px; padding-bottom:	20px">
						<table class="ms-authoringcontrols" style="MARGIN-BOTTOM: 5px" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Select product group<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:dropdownlist id="cboProductGroup" CssClass="ms-long" Width="60%" runat="server" AutoPostBack="True" onselectedindexchanged="cboProductGroup_SelectedIndexChanged"></asp:dropdownlist>
                                    <asp:textbox id="txtProductGroupCode" accessKey="G" runat="server" CssClass="ms-short" Width="30%" BorderStyle="Groove" MaxLength="30" ></asp:textbox>
                                    <asp:imagebutton id="imgProductGroupCodeSearch" ToolTip="Execute search" 
                                        style="CURSOR: hand" accessKey="P" 
                                        ImageUrl="../../_layouts/images/SPSSearch2.gif" runat="server" 
                                        CausesValidation="False" onclick="imgProductGroupCodeSearch_Click"></asp:imagebutton>
									<asp:requiredfieldvalidator id="Requiredfieldvalidator1" runat="server" CssClass="ms-error" ErrorMessage="'Product Group' must not be left blank." Display="Dynamic" ControlToValidate="cboProductGroup" ForeColor=" "></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Select product sub group<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:dropdownlist id="cboSubGroup" CssClass="ms-long" Width="60%" runat="server" AutoPostBack="True" onselectedindexchanged="cboProductSubGroup_SelectedIndexChanged"></asp:dropdownlist>
                                    <asp:textbox id="txtSubGroupCode" accessKey="C" runat="server" CssClass="ms-short" Width="30%" BorderStyle="Groove" MaxLength="30" ></asp:textbox>
                                    <asp:imagebutton id="imgSubGroupCodeSearch" ToolTip="Execute search" 
                                        style="CURSOR: hand" accessKey="P" 
                                        ImageUrl="../../_layouts/images/SPSSearch2.gif" runat="server" 
                                        CausesValidation="False" onclick="imgSubGroupCodeSearch_Click"></asp:imagebutton>
									<asp:requiredfieldvalidator id="Requiredfieldvalidator2" runat="server" CssClass="ms-error" ErrorMessage="'Product SubGroup' must not be left blank." Display="Dynamic" ControlToValidate="cboSubGroup" ForeColor=" "></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Select product<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:dropdownlist id="cboProducts" CssClass="ms-long" Width="60%" runat="server" AutoPostBack="True" onselectedindexchanged="cboProducts_SelectedIndexChanged"></asp:dropdownlist>
                                    <asp:textbox id="txtProductCode" accessKey="C" runat="server" CssClass="ms-short" Width="30%" BorderStyle="Groove" MaxLength="30" ></asp:textbox>
                                    <asp:imagebutton id="cmdProductCode" ToolTip="Execute search" style="CURSOR: hand" accessKey="P" ImageUrl="../../_layouts/images/SPSSearch2.gif" runat="server" CausesValidation="False" OnClick="cmdProductCode_Click"></asp:imagebutton>
									<asp:requiredfieldvalidator id="Requiredfieldvalidator6" runat="server" CssClass="ms-error" ErrorMessage="'Product' must not be left blank." Display="Dynamic" ControlToValidate="cboProducts" ForeColor=" "></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Select product variation<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer" style="HEIGHT: 21px"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%" style="HEIGHT: 21px">
									<asp:dropdownlist id="cboProductVariation" CssClass="ms-long" runat="server"></asp:dropdownlist>
									<asp:requiredfieldvalidator id="Requiredfieldvalidator7" runat="server" CssClass="ms-error" ErrorMessage="'Product Variation' must not be left blank." Display="Dynamic" ControlToValidate="cboProductVariation" ForeColor=" "></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="ms-sectionline" height="1"></td>
				</tr>
				<tr>
					<td valign="top" style="padding-bottom: 20px">
						<div class="ms-sectionheader" style="padding-bottom: 8px">Step 4:&nbsp;Promo Rates</div>
						<div class="ms-descriptiontext" style="padding-bottom:	10px">
							Enter qualifying quantity if items, promo will take effect.</div>
					</td>
					<td class="ms-colspace">&nbsp;</td>
					<td class="ms-authoringcontrols ms-formwidth" valign="top" style="PADDING-RIGHT:	10px; BORDER-TOP:	white 1px solid; PADDING-LEFT:	8px; padding-bottom:	20px">
						<table class="ms-authoringcontrols" style="MARGIN-BOTTOM: 5px" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Enter quantity of items purchased promo will take effect<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:TextBox id="txtQuantity" accessKey="G" CssClass="ms-short-numeric" runat="server" BorderStyle="Groove" MaxLength="20" onKeyPress="AllNum()"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label>Enter promo value (this can be in amount or in percentage)<font color="red">*</font></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%">
									<asp:TextBox id="txtPromoValue" accessKey="G" CssClass="ms-short-numeric" runat="server" BorderStyle="Groove" MaxLength="20" onKeyPress="AllNum()"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
							<tr>
								<td class="ms-authoringcontrols" style="padding-bottom:2px" colspan="2">
									<label></label>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"><img alt="" src="../../_layouts/images/trans.gif" width="10"></td>
								<td class="ms-authoringcontrols" width="100%">
									In Percentage
									<asp:CheckBox id="chkInPercentage" runat="server" Enabled="False"></asp:CheckBox>
								</td>
							</tr>
							<tr>
								<td class="ms-formspacer"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="ms-sectionline" height="1"></td>
				</tr>
				<tr>
					<td colspan="3" height="1" align="right">
						<table class="ms-toolbar" style="margin-left: 0px" cellpadding="2" cellspacing="0" border="0" width="100%">
							<tr>
								<td width="99%" class="ms-toolbar" id="align03" nowrap="nowrap" align="right"><img height="1" alt="" src="../../_layouts/images/blank.gif" width="1" />
								</td>
								<td class="ms-toolbar">
									<table cellspacing="0" cellpadding="1" border="0">
										<tr>
											<td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgSave" ToolTip="Add New Item" accessKey="S" tabIndex="1" height="16" width="16" border="0" alt="Add New Item" ImageUrl="../../_layouts/images/saveitem.gif" runat="server" CssClass="ms-toolbar" OnClick="imgSave_Click"></asp:imagebutton>&nbsp;
											</td>
											<td nowrap="nowrap"><asp:linkbutton id="cmdSave" ToolTip="Add New Item" accessKey="S" tabIndex="2" runat="server" CssClass="ms-toolbar" onclick="cmdSave_Click">Save and Additem</asp:linkbutton></td>
										</tr>
									</table>
								</td>
								<td class="ms-separator">
									<asp:Label id="lblSeparator1" runat="server">|</asp:Label></td>
								<td class="ms-toolbar">
									<table cellspacing="0" cellpadding="1" border="0">
										<tr>
											<td class="ms-toolbar" nowrap="nowrap"><asp:imagebutton id="imgDelete" ToolTip="Remove Selected Item" accessKey="N" tabIndex="3" height="16" width="16" border="0" alt="Remove Selected Item" ImageUrl="../../_layouts/images/delitem.gif" runat="server" CssClass="ms-toolbar" CausesValidation="False" OnClick="imgDelete_Click"></asp:imagebutton></td>
											<td nowrap="nowrap"><asp:linkbutton id="cmdDelete" ToolTip="Remove Selected Item" accessKey="X" tabIndex="4" runat="server" CssClass="ms-toolbar" CausesValidation="False" onclick="cmdDelete_Click">Remove Selected Item</asp:linkbutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top" style="padding-bottom: 20px" colspan="3">
						<div class="ms-sectionheader" style="padding-bottom: 8px">&nbsp;Stuffed Items in 
							the promo.</div>
						<div class="ms-descriptiontext" style="padding-bottom:	5px">
							Below are the list of items stuffed in the promo.</div>
					</td>
				</tr>
				<tr>
					<td colspan="3" height="1">
						<asp:datalist id="lstStuff" runat="server" Width="100%" ShowFooter="False" CellPadding="0"  OnItemDataBound="lstStuff_ItemDataBound" OnItemCommand="lstStuff_ItemCommand" >
							<HeaderTemplate>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
									<colgroup>
										<col width="10">
                                        <col width="10">
										<col width="15%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%" align="right">
										<col width="10%" align="right">
										<col width="10%" align="right">
										<col width="1">
									</colgroup>
									<tr>
										<th class="ms-vh2" style="padding-bottom: 4px">
											&nbsp;&nbsp;&nbsp;&nbsp;</th>
                                        <th class="ms-vh2" style="padding-bottom: 4px">
											&nbsp;&nbsp;&nbsp;&nbsp;</th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											<asp:hyperlink id="Hyperlink11" runat="server">Contact</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											<asp:hyperlink id="Hyperlink4" runat="server">Group</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											<asp:hyperlink id="Hyperlink5" runat="server">Sub Group</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											<asp:hyperlink id="Hyperlink6" runat="server">Product</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											<asp:hyperlink id="Hyperlink7" runat="server">Variation</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<asp:hyperlink id="Hyperlink8" runat="server">Quantity</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											<asp:hyperlink id="Hyperlink9" runat="server">Promo Value</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<asp:hyperlink id="Hyperlink10" runat="server">In Percent</asp:hyperlink></th>
										<th class="ms-vh2" style="padding-bottom: 4px">
										</th>
									</tr>
								</table>
							</HeaderTemplate>
							<ItemTemplate>
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
									<colgroup>
										<col width="10">
                                        <col width="10">
										<col width="15%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%" align="right">
										<col width="10%" align="right">
										<col width="10%" align="right">
										<col width="1">
									</colgroup>
									<tr>
										<td class="ms-vb-user">
											<input type="checkbox" id="chkList" runat="server" name="chkList" />
										</td>
                                        <td class="ms-vb-user">
                                            <asp:imagebutton id="imgItemDelete" commandname="imgItemDelete" ToolTip="Remove Selected Item" accessKey="N" tabIndex="3" height="16" width="16" border="0" alt="Remove Selected Item" ImageUrl="../../_layouts/images/delitem.gif" runat="server" CssClass="ms-toolbar" CausesValidation="False"></asp:imagebutton>
                                        </td>
										<td class="ms-vb-user">
											<asp:Label ID="lblContactName" Runat="server"></asp:Label>
										</td>
										<td class="ms-vb-user">
											<asp:Label ID="lblProductGroup" Runat="server"></asp:Label>
										</td>
										<td class="ms-vb-user">
											<asp:Label ID="lblProductSubGroup" Runat="server"></asp:Label>
										</td>
										<td class="ms-vb-user">
											<asp:Label ID="lblProduct" Runat="server"></asp:Label>
										</td>
										<td class="ms-vb-user">
											<asp:Label ID="lblVariation" Runat="server"></asp:Label>
										</td>
										<td class="ms-vb-user">
											<asp:Label ID="lblQuantity" Runat="server"></asp:Label>
										</td>
										<td class="ms-vb-user">
											<asp:Label ID="lblPromoValue" Runat="server"></asp:Label>
										</td>
										<td class="ms-vb-user">
											<asp:CheckBox id="chkInPercent" Runat="server" Enabled="False"></asp:CheckBox>
										</td>
										<td class="ms-vb2">
											<A class="DropDown" id="A1" href="" runat="server">
												<asp:Image id="Image1" ImageUrl="../../_layouts/images/DLMAX.gif" runat="server" alt="Show" Visible="false"></asp:Image></A>
										</td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:datalist>
					</td>
				</tr>
				<tr>
					<td class="ms-formspacer" colspan="3"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="3" class="ms-sectionline" height="2"><img alt="" src="../../_layouts/images/empty.gif" /></td>
	</tr>
	<tr>
		<td colspan="3"><img height="10" alt="" src="../../_layouts/images/blank.gif" width="1"/></td>
	</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>