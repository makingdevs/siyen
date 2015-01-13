var payuModule = (function(){
  
  var getAccountId = function(){ return  $('#accountId').val();},
      getMerchantId = function(){ return  $('#merchantId').val();},
      getApiKey = function(){ return  $('#apiKey').val();},
      getReferenceCode = function(){ return  $('#referenceCode').val();},
      getTax = function(){ return  $('#tax').val();},
      getTaxReturnBase = function(){ return  $('#taxReturnBase').val();},
      getCurrency = function(){ return  $('#currency').val();},
      getSignature = function(){ return  $('#signature').val();},
      getTest = function(){ return  $('#test').val();},
      getResponseUrl = function(){ return  $('#responseUrl').val();},
      getConfirmationUrl = function(){ return  $('#confirmationUrl').val();},
      getDescription = function(){ return  $('#description').val();},
      getPayerFullName = function(){ return  $('#payerFullName').val();},
      getBuyerEmail = function(){ return  $('#buyerEmail').val();},
      getAmount = function(){ return  $('#amount').val();},
      getUrlPayU = function(){ return $('#urlPayU').val();};
  //functions
  var initModule, onSubmitPayU, hasInvalidFileds, setSignature, showMessage;

  initModule = function(){
    $( "#amount" ).change(function() {
      setSignature();
    });
  };  

  onSubmitPayU = function(){
    if(hasInvalidFileds()){
      return false;
    }
    return true;
  };

  showMessage = function(msg){
    console.log(msg);
  };

  setSignature = function(){
    var signature = getApiKey()+"~"+getMerchantId()+"~"+getReferenceCode()+"~"+getAmount()+"~"+getCurrency();
    console.log("antes de encriptar-->>"+signature);
    signature = CryptoJS.MD5(signature);
    $('#signature').val(signature);
  };

  hasInvalidFileds = function(){
    if(getDescription() == ""){
      showMessage("Elige un curso");
      return true;
    }
    if(getPayerFullName() == ""){
      showMessage("Escribe tu nombre");
      return true;
    }
    if(getBuyerEmail() == ""){
      showMessage("Escribe tu email");
      return true;
    }
    if(getAmount() == ""){
      showMessage("Cantidad a pagar es necesaria");
      return true;
    }
    return false;
  };

  return {
    onSubmitPayU : onSubmitPayU,
    initModule : initModule
  }
}());
payuModule.initModule();