$('#select_all').trigger("click",function(){
    var check = $('input[type="checkbox"]');
    check.prop("checked", !check.prop("checked"));
});