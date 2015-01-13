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
    $('.hero-unit').find( ".alert" ).remove();
    var htmlAlert = '<div class="alert alert-block"><button type="button" class="close" data-dismiss="alert">&times;</button><h4>Olvidaste..</h4>'+msg+'</div>';
    $('.hero-unit').prepend(htmlAlert);
  };

  setSignature = function(){
    var signature = getApiKey()+"~"+getMerchantId()+"~"+getReferenceCode()+"~"+getAmount()+"~"+getCurrency();
    signature = CryptoJS.MD5(signature);
    $('#signature').val(signature);
  };

  hasInvalidFileds = function(){
    if(getDescription() == ""){
      showMessage("eligir un curso");
      return true;
    }
    if(getPayerFullName() == ""){
      showMessage("escribir tu nombre");
      return true;
    }
    if(getBuyerEmail() == ""){
      showMessage("escribir tu email");
      return true;
    }
    if(getAmount() == ""){
      showMessage("colocar la cantidad a pagar");
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