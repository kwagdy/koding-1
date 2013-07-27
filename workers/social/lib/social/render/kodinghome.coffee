module.exports = ->

  """

  <!doctype html>
  <html lang="en">
  <head>
    <title>Koding</title>
    #{getStyles()}
  </head>
  <body class='koding'>

    <!--[if IE]>
    <script>(function(){window.location.href='/unsupported.html'})();</script>
    <![endif]-->

    <div class="kdview" id="kdmaincontainer">
      <div id="invite-recovery-notification-bar" class="invite-recovery-notification-bar hidden"></div>
      <header class="kdview" id='main-header'>
        <a id="koding-logo" href="#"><span></span></a>
      </header>
      <div id="home-intro" class="kdview"></div>
      <section class="kdview" id="main-panel-wrapper">
        <div class="kdview" id="sidebar-panel">
          <div class="kdview" id="sidebar">
            <div id="main-nav">
              <div class="avatar-placeholder">
                <div id="avatar-area">
                  <div class="avatarview avatar-image-wrapper" style="width: 160px; height: 76px; background-image: url(//api.koding.com/images/defaultavatar/default.avatar.160.png);"></div>
                </div>
              </div>
              <div class="kdview actions">
                <a class="notifications" href="#"><span class="count"><cite>0</cite></span><span class="arrow-wrap"><span class="arrow"></span></span></span><span class="icon"></span></a>
                <a class="messages" href="#"><span class="count"><cite>0</cite></span><span class="arrow-wrap"><span class="arrow"></span></span></span><span class="icon"></span></a>
                <a class="group-switcher" href="#"><span class="count"><cite>0</cite><span class="arrow-wrap"><span class="arrow"></span></span></span><span class="icon"></span></a>
              </div>
              <div class="kdview status-leds"></div>
              <div class="kdview kdlistview kdlistview-navigation">
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix selected">
                  <a class="title" href="#"><span class="main-nav-icon home"></span>Home</a>
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix">
                  <a class="title" href="#"><span class="main-nav-icon activity"></span>Activity</a>
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix">
                  <a class="title"><span class="main-nav-icon topics"></span>Topics</a>
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix">
                  <a class="title"><span class="main-nav-icon members"></span>Members</a>
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix">
                  <a class="title"><span class="main-nav-icon groups"></span>Groups</a>
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix">
                  <a class="title"><span class="main-nav-icon develop"></span>Develop</a>
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix">
                  <a class="title"><span class="main-nav-icon apps"></span>Apps</a>
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix separator">
                  <hr class="">
                </div>
                <div class="kdview kdlistitemview kdlistitemview-default navigation-item clearfix account">
                  <a class="title" href="#"><span class="main-nav-icon invite-friends"><span data-paths="quota usage">0</span></span>Invite Friends</a>
                </div>
              </div>
              <div class="kdview kdlistview kdlistview-footer-menu">
                <div class="kdview kdlistitemview kdlistitemview-default help"><span></span></div>
                <div class="kdview kdlistitemview kdlistitemview-default about"><span></span></div>
                <div class="kdview kdlistitemview kdlistitemview-default chat"><span></span></div>
              </div>
            </div>
            <div id="finder-panel"></div>
          </div>
        </div>
        <div class="kdview" id="content-panel">
          <div class="kdview kdscrollview kdtabview" id="main-tab-view">
            <div id='maintabpane-activity' class="kdview content-area-pane activity content-area-new-tab-pane clearfix kdtabpaneview active">
              <div id="content-page-activity" class="kdview content-page activity kdscrollview">
                <div class="kdview screenshots extra-wide" id="home-header">
                  <div class="home-links kdview" id="home-login-bar">
                    <a class="custom-link-view browse orange" href="/Join"><span class="icon"></span><span class="title">Learn more...</span></a>
                    <a class="custom-link-view join green" href="/Join"><span class="icon"></span><span class="title">Request an Invite</span></a>
                    <a class="custom-link-view register" href="/Register"><span class="icon"></span><span class="title">Register an account</span></a>
                    <a class="custom-link-view login" href="/Login"><span class="icon"></span><span class="title">Login</span></a>
                  </div>
                  <div id="home-counter-bar" class="counters">
                    <figure class="counter">
                      <h6 class="title">Members:</h6>
                      <div><i><span></span>0</i></div>
                    </figure>
                    <figure class="counter">
                      <h6 class="title">Running VMs:</h6>
                      <div><i><span></span>0</i></div>
                    </figure>
                    <figure class="counter">
                      <h6 class="title">Groups:</h6>
                      <div><i><span></span>0</i></div>
                    </figure>
                    <figure class="counter">
                      <h6 class="title">Topics:</h6>
                      <div><i><span></span>0</i></div>
                    </figure>
                    <figure class="counter">
                      <h6 class="title">Thoughts shared:</h6>
                      <div><i><span></span>0</i></div>
                    </figure>
                  </div>
                </div>
                <div class="kdview fl common-inner-nav">
                  <div class="kdview listview-wrapper list">
                    <h4 class="kdview kdheaderview list-group-title">
                      <span>FILTER</span>
                    </h4>
                    <ul class="kdview kdlistview kdlistview-default">
                      <li class="kdview kdlistitemview kdlistitemview-default Public selected"><a href="#">Public</a></li>
                    </ul>
                  </div>
                  <div class="kdview listview-wrapper list">
                    <h4 class="kdview kdheaderview list-group-title">
                      <span>SHOW ME</span>
                    </h4>
                    <ul class="kdview kdlistview kdlistview-default">
                      <li class="kdview kdlistitemview kdlistitemview-default"><a href="#">Everything</a></li>
                      <li class="kdview kdlistitemview kdlistitemview-default"><a href="#">Status Updates</a></li>
                      <li class="kdview kdlistitemview kdlistitemview-default"><a href="#">Blog Posts</a></li>
                      <li class="kdview kdlistitemview kdlistitemview-default"><a href="#">Code Snippets</a></li>
                      <li class="kdview kdlistitemview kdlistitemview-default"><a href="#">Discussions</a></li>
                      <li class="kdview kdlistitemview kdlistitemview-default"><a href="#">Tutorials</a></li>
                    </ul>
                  </div>
                  <div class="kdview help-box">
                    <div>
                      <cite>NEED HELP?</cite> <a href="#"><span data-paths="subtitle" id="el-189">About Your Activity Feed</span></a>
                    </div>
                  </div>
                </div>
                <div class="kdview activity-content feeder-tabs">
                  <div class="kdview listview-wrapper">
                    <div class="kdview feeder-header clearfix"><span>Latest Activity</span></div>
                    <div class="kdview kdscrollview">
                      <div class="kdview kdlistview kdlistview-default activity-related"></div>
                      <div class="lazy-loader">Loading...</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>

  #{KONFIG.getConfigScriptTag { entryPoint: { slug : 'koding', type: 'group' }, roles: ['guest'], permissions: [] } }
  #{getScripts()}
  </body>
  </html>
  """



getStyles =->
  """
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Koding" />
  <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1" />
  <link rel="shortcut icon" href="/images/favicon.ico" />
  <link rel="fluid-icon" href="/images/kd-fluid-icon512.png" title="Koding" />
  <link rel="stylesheet" href="/css/kd.#{KONFIG.version}.css" />
  """

getScripts =->
  """
  <script src="/js/require.js"></script>

  <script>
    require.config({baseUrl: "/js", waitSeconds:15});
    require(["order!/js/highlightjs/highlight.pack.js","order!/js/kd.#{KONFIG.version}.js"]);
  </script>

  <script type="text/javascript">(function(e,b){if(!b.__SV){var a,f,i,g;window.mixpanel=b;a=e.createElement("script");a.type="text/javascript";a.async=!0;a.src=("https:"===e.location.protocol?"https:":"http:")+'//cdn.mxpnl.com/libs/mixpanel-2.2.min.js';f=e.getElementsByTagName("script")[0];f.parentNode.insertBefore(a,f);b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==
  typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.track_charge people.clear_charges people.delete_user".split(" ");for(g=0;g<i.length;g++)f(c,i[g]);
  b._i.push([a,e,d])};b.__SV=1.2}})(document,window.mixpanel||[]);
  mixpanel.init("e25475c7a850a49a512acdf04aa111cf");</script>

  <script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-6520910-8']);
    _gaq.push(['_setDomainName', 'koding.com']);
    _gaq.push(['_trackPageview']);
    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
  </script>

  """
