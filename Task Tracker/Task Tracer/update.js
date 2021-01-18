function get_list_items (){
  //alert("s");
  const lis = document.getElementById('todolist').getElementsByTagName('li');
  const lis2 = document.getElementById('inprogresslist').getElementsByTagName('li');
  const lis3 = document.getElementById('revisionlist').getElementsByTagName('li');
  const lis4 = document.getElementById('checklist').getElementsByTagName('li');
  const lis5 = document.getElementById('donelist').getElementsByTagName('li');
  for (let i = 0; i <= lis.length - 1; i++) {
      kaydet(lis[i].getElementsByTagName('input')[0].value,1);
  }
  for (let i = 0; i <= lis2.length - 1; i++) {
     kaydet(lis2[i].getElementsByTagName('input')[0].value,2);
  }
  for (let i = 0; i <= lis3.length - 1; i++) {
      kaydet(lis3[i].getElementsByTagName('input')[0].value,3);
  }
  for (let i = 0; i <= lis4.length - 1; i++) {
     kaydet(lis4[i].getElementsByTagName('input')[0].value,4);
  }
  for (let i = 0; i <= lis5.length - 1; i++) {
     kaydet(lis5[i].getElementsByTagName('input')[0].value,5);
  }
}
function kaydet(id,state_id){
     $.ajax({
       type: "POST",
       url: "main.aspx/save",
        data: "{id:'"+id+"',state_id:'"+state_id+"'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        succes:function(){
          //alert("success");
        }
     });
 }
