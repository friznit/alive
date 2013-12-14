@extends('public.layouts.default')

{{-- Content --}}
@section('content')

<div class="jumbotron black-panel" id="Trailer">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <!--<iframe width="420" height="500" src="http://www.youtube.com/apiplayer?video_id=88iDovAvk80&version=3" frameborder="0" modestbranding allowfullscreen></iframe>-->
<iframe width="420" height="500" src="//www.youtube.com/embed/88iDovAvk80" autohide="3" frameborder="0" showinfo="0" modestbranding="1" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="jumbotron alive-background-panel" id="Welcome">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <img id="welcome_logo" src="{{ URL::to('/') }}/img/home_logo.png" class="img-responsive"/>
                <p id="welcome_text">ALIVE is the next generation dynamic persistent campaign for ArmA3. Developed by the Multi Session Operations team, the easy to use modular mission framework provides everything that players and mission makers need to set up and run realistic military operations in almost any scenario up to Company level, including command, combat support, service support and logistics.</p>
            </div>
            <div id="welcome_image" class="col-md-5 col-md-offset-1">
                <img src="{{ URL::to('/') }}/img/action3.jpg" class="img-responsive light-blue-border" />
            </div>
        </div>
    </div>
</div>

<div class="jumbotron light-blue-panel" id="Gameplay">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h2>Gameplay</h2>
                <p>ALiVE is a dynamic campaign mission framework. The editor placed modules are designed to be intuitive but highly flexible so you can create a huge range of different scenarios by simply placing a few modules and markers. The AI Commanders have an overall mission and a prioritised list of objectives that they will work through autonomously.  Players can choose to tag along with the AI and join the fight, take your own squad of AI or other players and tackle your own objectives or just sit back and watch it all unfold.</p>
                <p>Mission makers may wish to experiment by synchronizing different modules to each other, or  using standalone ALiVE modules as a backdrop for dynamic missions and campaigns, enhancing scenarios created with traditional editing techniques.  ALiVE can significantly reduce the effort required to make a complex mission by adding ambience, support and persistence at the drop of a module.</p>
            </div>
            <div class="col-md-5 col-md-offset-1">
                <img src="{{ URL::to('/') }}/img/action4.jpg" class="img-responsive dark-border" />
            </div>
        </div>
    </div>
</div>

<div class="jumbotron white-panel" id="Download">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <h2>Download</h2>
                <table class="table">
                    <tr>
                        <th>Version</th>
                        <th>Compatible With</th>
                        <th></th>
                    </tr>
                    <tr class="success">
                        <td>0.5.4</td>
                        <td>Arma 3 Stable 1.08.113494</td>
                        <td><a class="btn btn-primary btn-lg pull-right" href="http://dev-heaven.net/attachments/download/21377/@alive_0-5-4.7z"><i class="fa fa-download"></i> Download</a></td>
                    </tr>
                </table>
                <br/><h2>Installation</h2>
                <p>Dependencies:  ALiVE Requires <b>CBA_A3</b><br/><br/>
                As with any other mod, extract @ALiVE into Steamapps/Common/ArmA 3 or My Documents/ArmA3.<br/><br/>
                Then either add @ALiVE to your shortcut -mod line, or enable it using the in game Expansions menu or use a launcher like Play with Six or ArmA3Sync.<br/><br/>
                Further instructions for installing mods are in this handy guide on <a target="_blank" href="http://www.armaholic.com/forums.php?m=posts&q=20866]ArmAholic">Armaholic</a>
                </p>
            </div>
            <div class="col-md-5">
                <img src="{{ URL::to('/') }}/img/alivebox.gif" class="img-responsive" />
            </div>
        </div>
    </div>
</div>

<div class="jumbotron dark-panel" id="Media">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2>Media</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <p>In the first techdemo video a brief glimpse under the hood of the Advanced Light Infantry Virtual Environment modification.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/jjeD0a7MdoU" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-2">
                <p></p>
            </div>
            <div class="col-md-4">

            </div>
        </div>
        <div class="row top-margin">
            <div class="col-md-2">
                <p>ALiVE logistics and reinforcement system test. A hectic 3 faction battle in a small valley on the western side of Altis.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/IjaO8Gm3jHQ" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-2">
                <p>The mechanics behind the valley of JPD. In this debug test the Profile System, OPCOM, and an alpha version of the Logistics / Re-enforcement module send waves of units and competing factions against each other.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/xbjVG8IFFLk" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="jumbotron white-panel" id="Editors">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h2>Editors</h2>
                <p>The following resources will help you get started with using the ALiVE mod's modules.</p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <br/><h4>ALiVE User Manual</h4>
                <a class="btn btn-yellow btn-lg"href="http://dev-heaven.net/attachments/download/21306/ALiVE%20Manual%20Compressed.pdf"><i class="fa fa-download"></i> Download User Manual</a><br/>
            </div>
        </div>
        <div class="row top-margin">
             <div class="col-md-6">
                <br/><h4>Sample Missions</h4><br/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <p><b>Pyrgos Assault</b><br/><small>by [KH]Jman</small><br/>The Rebels have taken over Pyrgos. Take it back and drive them into the sea!. Player respawn and revive are enabled. You will see player's injured via markers. </p>
                <a class="btn btn-yellow" href="downloads/CO10_Pyrgos_Assault_v1_7.Altis.zip"><i class="fa fa-download"></i> Download</a><br/>
            </div>
            <div class="col-md-4">
                <img src="{{ URL::to('/') }}/img/pyrgos.jpg" class="img-responsive" />
            </div>
            <div class="col-md-2">

            </div>
            <div class="col-md-4">

            </div>
        </div>
        <br/>
        <div class="row top-margin">
            <div class="col-md-2">
                <p><b>Valley of Just Pure Death</b><br/><small>by ARJay</small><br/>A hectic 3 faction battle in a small valley on the western side of Altis.</p>
                <a class="btn btn-yellow" href="downloads/ALiVE_ValleyOfJPD.Altis.zip"><i class="fa fa-download"></i> Download</a><br/>
            </div>
            <div class="col-md-4">
               <img src="{{ URL::to('/') }}/img/jpd.jpg" class="img-responsive" />
            </div>
            <div class="col-md-2">
                <p><b>Mountain War</b><br/><small>by (AEF)Spinfx</small><br/>Stratis is split down the middle with BLUFOR holding the western side and OPFOR holding the east. Featuring BIS support modules, BTC Revive, and VAS.</p>
                <a class="btn btn-yellow" href="downloads/ALiVE_MountainWar.Stratis.zip"><i class="fa fa-download"></i> Download</a><br/>
            </div>
            <div class="col-md-4">
                <img src="{{ URL::to('/') }}/img/mountain_war.jpg" class="img-responsive" />
            </div>
        </div>
        <div class="row top-margin">
            <div class="col-md-6">
                <br/><h4>Simple Mission Tutorials</h4><br/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <p>The first episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The Profile System module.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/g-8qwL61an4" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-2">
                <p>The second episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The Profile System module continued and the Military Placement module.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/gDcG0srHW8A" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
        <div class="row top-margin">
            <div class="col-md-2">
                <p>The third episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The Military placement module continued.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/rYI94Q80VCw" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-2">
                <p>The forth episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The OPCOM module.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/LIJLy54k9CU" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
        <div class="row top-margin">
            <div class="col-md-2">
                <p>The fifth episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The Civilian Placement module.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/KKAAO_rNH_Y" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-2">
                <p>The sixth episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The CQB module.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/pP11I43-E10" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
        <div class="row top-margin">
            <div class="col-md-2">
                <p>The seventh episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The Combat Support modules</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/LysKvQw0W7I" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-2">
                <p>The eighth episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: The Military Intelligence, Military Sector Display, and Player Sector Display modules</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/IO8gRLuAE4k" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
        </div>
        <div class="row top-margin">
            <div class="col-md-2">
                <p>The ninth episode in a series of videos showing you how to use the ALiVE modules to create a simple mission. In this episode: AI Skill, Crew Info, Dynamic Weather, Garbage collector, Player Tags and the View Settings modules.</p>
            </div>
            <div class="col-md-4">
                <div class="flex-video widescreen" style="margin: 0 auto;text-align:center;">
                    <iframe width="420" height="500" src="//www.youtube.com/embed/VwdHmXwBKD0" frameborder="0" allowfullscreen></iframe>
                </div>
            </div>
            <div class="col-md-2">

            </div>
            <div class="col-md-4">
                <p><br/>Download the tutorial missions and follow along with the videos.</p>
                <a class="btn btn-yellow btn-lg pull-right"href="downloads/ALiVE_tutorial_missions.zip"><i class="fa fa-download"></i> Download Tutorial missions</a>
            </div>
        </div>
    </div>
</div>

<div class="jumbotron dark-panel" id="ALiVEWarRoom">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h2><img src="{{ URL::to('/') }}/img/alive_warroom_sm.png" class="img-responsive" /></h2>

                <p>ALiVE mod introduces revolutionary web services integration by streaming Arma 3 in game data to our ALiVE War Room web platform. War Room allows players and groups to review current and past operations as well keep track of individual and group performance statistics.</p>
                <p>War Room offers groups membership to a "virtual" task force operating across the various AO's offered by the Arma 3 engine. War Room exposes task force wins, losses and leaderboards for performance. The platform will provide live streaming capabilities for BLUFOR tracking in a web browser as well as Twitch integration for live helmet cam views and the much awaited ALiVE xStream functionality.</p>
                <p>Beside events, statistics and streaming, War Room provides the platform for persisting Multiplayer Campaigns. This allows groups to run "multi-session operations" by storing game state to a cloud based database. Group admins can update campaign data via the War Room, such as adding map markers, objectives, editing loadouts or adding vehicles and units to the campaign - all via the web platform.</p>
                <!--<p>We believe ALiVE War Room is a revolutionary step in Arma gaming - sign up today!</p>-->
            </div>
            <div class="col-md-5 col-md-offset-1">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">ALiVE War Room</h3>
                    </div>
                    <div class="panel-body">
                        <p>Registrations opening soon!</p>
                    </div>
                </div>
            </div>
            <!--
            <div class="col-md-5 col-md-offset-1">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Join the ALiVE War Room</h3>
                    </div>
                    <div class="panel-body">
                        <a href="{{ URL::to('user/register') }}" class="btn btn-yellow">Sign Up Now!</a>
                    </div>
                </div>
            </div>
            -->
        </div>
    </div>
</div>

<div class="jumbotron white-panel" id="FAQ">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2>FAQ's</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <p><i class="fa fa-comment-o"></i> <b>Is ALiVE for Arma2, Operation Arrowhead or Arma3?</b></p>
                <p><i class="fa fa-comment"></i> It's for Arma 3. We technically could back-port most of it to Arma 2 OA, but we didn't think that supported our fresh start on a shiny new gaming platform.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Will ALiVE support Headless Client (HC)?</b></p>
                <p><i class="fa fa-comment"></i> Server performance with Profiled Virtual AI is already sufficient, so there's been no driver to use HC yet. However, we will provide an option in Profile System to spawn on HC in the first release!</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>ALIVE Object Oriented SQF - what is this wizardry, something you guys designed in-house?</b></p>
                <p><i class="fa fa-comment"></i> Wolffy first wrote OOSQF about in Sept 2012 on the MSO Developers Blog. Its a bit clunky - yes,. But it serves its purpose in the way we code cleaner and more reliably. And puts us in good stead when/if BIS release Java support for ARMA.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Will it be possible to set up the AI skill with your stand-alone admin actions?</b></p>
                <p><i class="fa fa-comment"></i> Yes, we have a module that allows you to customise AI skill for the mission.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>How's the performance in multiplayer when there are players mixed at two or more different objective areas on the map? Does it noticeably take a steep dive in performance?</b></p>
                <p><i class="fa fa-comment"></i> We are working on a limiter to the profile system, where the mission maker can set a hard top limit on the amount of 'active' profiles that can be in play at any one time. This will of course require testing on your hardware, and configured for the types of ops you are looking to support. I think it will be a reasonable compromise, as we all know Arma can only run X number of AI for any given system with Y number of players.</p>
            </div>
            <div class="col-md-4">
                <p><i class="fa fa-comment-o"></i> <b>How do I get access to the test version?</b></p>
                <p><i class="fa fa-comment"></i> We will not be extending the closed testing of ALiVE to any other groups at this stage. However, we will be releasing a public alpha for you all to test in due course.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Do you have any general performance concerns?</b></p>
                <p><i class="fa fa-comment"></i> Profiling or not, there is clearly a limit to what servers can handle with 'Visual' AI - lots of players in lots of locations across the map spawning lots of AI into the Visual World will of course have an impact and BIS is the only one that can do anything about that. However, note that ALiVE Placement (the system that analyses maps for objectives and automatically places AI groups) is completely customisable - for example, you can limit it to only a Platoon strength group and set a small Tactical Area of Responsibility (TAOR). Then place one for the other faction and watch them fight it out. Synch a Logistics module with unlimited supplies too if you want a perpetual micro battle. This would take about 5 minutes in the editor.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Can it be used on all maps?</b></p>
                <p><i class="fa fa-comment"></i> Our military placement and objectives modules, automatically scan maps for military, civilian infrastructure etc. We have it already working for a number of BIS and community made maps.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Also are you guys wizards by any chance?</b></p>
                <p><i class="fa fa-comment"></i> No</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Can I create my own pbo that changes the way ALiVE works, such as replacing functions or features to work with my own addons?</b></p>
                <p><i class="fa fa-comment"></i> No, users and the community do not have permission to edit, change, replace ALiVE content through the use of new addons. Clearly any changes required with ALiVE should be submitted to the dev team for inclusion in the official ALiVE build for all to enjoy.</p>
            </div>
            <div class="col-md-4">
                <p><i class="fa fa-comment-o"></i> <b>When will you be releasing ALiVE?</b></p>
                <p><i class="fa fa-comment"></i> We are following the well-known release schedule used by all addon makers in the community, and will release it "when it's ready" which will be "soon™"</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Will you have "Patrol Ops" like side missions or tasks?</b></p>
                <p><i class="fa fa-comment"></i> Yes, we will be including an optional Player Task Generator for those who want more directed content within the ALiVEsandbox. This is in early stages of development but the intent is for OPCOM to provide relevant but specialist tasks for the player that will enhance the overall war effort, rather than just random side missions.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Is it customizable so you can choose the enemies that spawn?</b></p>
                <p><i class="fa fa-comment"></i> Yes, you can choose the enemy force by faction and size (battalion, company, & platoon). The modules are configurable in the editor, so you can choose sides or factions, custom ones too. You can also select things such as size of the enemy force and posture. Combining modules and settings you can create dynamic and credible invasions or insurgency campaigns. For those of you familiar with MSO we will be introducing modules such as Terror Cells, IED/Suicide Bomber, Roadblocks, AAA sites etc.</p>
                <hr/>
                <p><i class="fa fa-comment-o"></i> <b>Can I depbo, edit and update any of the ALiVE modules for my own use?</b></p>
                <p><i class="fa fa-comment"></i> No, users do not have permission to edit and distribute ALiVE - as stated by the license. Users and the community are encouraged to submit code updates/fixes/new features to the development team for inclusion in the ALiVE addon.</p>
            </div>
        </div>
    </div>
</div>
<!--
<div class="jumbotron white-panel" id="Helpout">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <h2>Help out</h2>
            </div>
            <div class="col-md-5">
                <a class="coinbase-button" data-code="d8ebf42741de6073065e8c00ceaf6223" data-button-style="donation_large" href="https://coinbase.com/checkouts/d8ebf42741de6073065e8c00ceaf6223">Donate Bitcoins</a><script src="https://coinbase.com/assets/button.js" type="text/javascript"></script>
            </div>
        </div>
    </div>
</div>
-->
@stop
