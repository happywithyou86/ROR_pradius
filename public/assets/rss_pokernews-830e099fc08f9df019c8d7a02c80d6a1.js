google.load("feeds", "1");

$( document ).ready(function() {
  if(document.getElementById('poker_news_container_title') != null)
  {
    google.setOnLoadCallback(initialize);
  }
});

function initialize() {
  var feed = new google.feeds.Feed("http://www.pokernews.com/rss.php?subset=HY2xDgIxDEP%2FJfMb2l6bpPcriPU2EKLAgvh3rFueLdmJv3a3%2FZKF2hi0JDtZ8U6XccZEGozENzyIZCpvpEwhJ16JIAfRcNokG7ExN0IJXgj90U0S%2FYp9NChZkqrJKv%2BwvWC3k8fJ18m3SvZcy35%2F");
  feed.load(function(result) {
    if (!result.error) {
      var container = document.getElementById("poker_news_feed");
      
      for (var i = 0; i < result.feed.entries.length; i++) {
        var entry = result.feed.entries[i];
        var div = document.createElement("div");
        div.innerHTML = "<a href='" + entry.link + "'target='_Blank''" + "'><p><b>" + entry.title +  "</b></p></a>"
        div.innerHTML = div.innerHTML + entry.content;
        container.appendChild(div);
        var hr = document.createElement("hr");
        container.appendChild(hr);
      }
    }
  });
}
    
;
