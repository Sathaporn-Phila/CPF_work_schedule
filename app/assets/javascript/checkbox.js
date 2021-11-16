function selects(){  
    var ele=document.getElementsByName('chk[]');
    console.log("ee")  
    for(var i=0; i<ele.length; i++){  
        if(ele[i].type=='checkbox')
            ele[i].checked=true;  
    }  
}  
function deSelect(){  
    var ele=document.getElementsByName('chk[]');  
    for(var i=0; i<ele.length; i++){  
        if(ele[i].type=='checkbox')  
            ele[i].checked=false;  
          
    }  
}  
$('#check_all').on("click", function(){
    console.log("hello")
    var cbxs = $('input[type="checkbox"]');
    cbxs.prop("checked", !cbxs.prop("checked"));
  });