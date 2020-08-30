//   var video = document.getElementById("videoTest");
//         video.addEventListener("ended", function() { // 对视频播放添加结束事件，播放结束后调用videoNext()方法
//             videoNext();
//         }, false);
//         var videoNext = function(){
//             var vid = $('#videoTest').data('vid');
//             $.ajax({
//                 url : '../viedo/刀说异数.mp4', // 获取下个视频相关信息，如播放地址等
//                 data : {
//                     videoId : vid
//                 },
//                 dataType : 'json',
//                 type : 'get',
//                 success : function(res) {
//                     var data = res.data;
//                     $('#videoTest').attr('src', data.playUrl);
//                     $('#videoTest').data('vid', data.id);
//                     video.load(); // 加载播放视频
//                     video.play();
//                 }
//             });
//         }

//点击ctrl按钮，按顺序播放视频

function ctrlBtn(){
    var ctrl = document.getElementById("ctrlBtn"); //获取按钮对象
    for(var i=1 ; i<=5 ; i++){
        if(ctrl.onclick){
            document.getElementById("if"+i).style.display=none ;
            document.getElementById("if"+(parseInt(i+1))).style.display=block ;
        }

        if(i==5){ //如果i是最后一个
            i=1 ;
        }
    }
    
}
