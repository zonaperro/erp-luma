
function ChangePriceComputeMarginPPBranchTransfer(obj)
{
	var margin = 0; 
	var purchaseprice = 0; 
	var saleprice = 0;
	
	purchaseprice = document.getElementById("ctrlPost_txtPrice").value;
	margin = document.getElementById("ctrlPost_txtMargin").value;
	margin = margin / 100;
	margin = purchaseprice * margin;
	saleprice = +purchaseprice + +margin;
	document.getElementById("ctrlPost_txtSellingPrice").value = saleprice.toFixed(3);
}

function ChangePriceComputeMarginByPriceMPBranchTransfer(obj)
{
	var margin = 0; 
	var purchaseprice = 0; 
	var saleprice = 0;
	
	saleprice = document.getElementById("ctrlPost_txtSellingPrice").value;
	purchaseprice = document.getElementById("ctrlPost_txtPrice").value;
	margin = saleprice - purchaseprice;
	margin = margin / purchaseprice;
	margin = margin * 100;
	document.getElementById("ctrlPost_txtMargin").value = margin.toFixed(3);
}

function ChangePriceComputeMarginMPBranchTransfer(obj)
{
	var margin = 0; 
	var purchaseprice = 0; 
	var saleprice = 0;
	
	purchaseprice = document.getElementById("ctrlPost_txtPrice").value;
	margin = document.getElementById("ctrlPost_txtMargin").value;
	margin = margin / 100;
	margin = purchaseprice * margin;
	saleprice = +purchaseprice + +margin;
	document.getElementById("ctrlPost_txtSellingPrice").value = saleprice.toFixed(3);
	
	ComputeAmountPost();
}