@extends('admin.layouts.default')

{{-- Content --}}
@section('content')

<div class="dark-panel form-holder">

    <div class="container">
        <div class="row">

            <div class="col-md-12">
                @include('alerts/alerts')
            </div>

        </div>
        <div class="row">

            <div class="col-md-4">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Edit Server</h3>
                    </div>
                    <form action="{{ URL::to('admin/server/edit') }}/{{ $server->id }}" method="post">

                        {{ Form::token() }}

                        <div class="panel-body">

                             <div class="form-group {{ $errors->has('name') ? 'has-error' : '' }}" for="name">
                                <label class="control-label" for="name">Server name</label>
                                <input name="name" value="{{ (Request::old('name')) ? Request::old("name") : $server->name }}" type="text" class="form-control" placeholder="username">
                                <?php
                                if($errors->has('name')){
                                    echo '<span class="label label-danger">' . $errors->first('name') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('hostname')) ? 'has-error' : '' }}" for="hostname">
                                <label class="control-label" for="hostname">Hostname</label>
                                <input name="hostname" value="{{ (Request::old('hostname')) ? Request::old("hostname") : $server->hostname }}" type="text" class="form-control" placeholder="Hostname">
                                <?php
                                if($errors->has('hostname')){
                                    echo '<span class="label label-danger">' . $errors->first('hostname') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('ip')) ? 'has-error' : '' }}" for="ip">
                                <label class="control-label" for="ip">IP Address</label>
                                <input name="ip" value="{{ (Request::old('ip')) ? Request::old("ip") : $server->ip }}" type="text" class="form-control" placeholder="IP Address">
                                <?php
                                if($errors->has('ip')){
                                    echo '<span class="label label-danger">' . $errors->first('ip') . '</span>';
                                }
                                ?>
                            </div>

                            <div class="form-group {{ ($errors->has('note')) ? 'has-error' : '' }}" for="note">
                                <label class="control-label" for="note">Notes</label>
                                <textarea name="note" class="form-control" placeholder="Notes">{{ (Request::old('note')) ? Request::old("note") : $server->note }}</textarea>
                                <?php
                                if($errors->has('note')){
                                    echo '<span class="label label-danger">' . $errors->first('note') . '</span>';
                                }
                                ?>
                            </div>

                        </div>
                        <div class="panel-footer clearfix">
                            <div class="btn-toolbar pull-right" role="toolbar">
                                <input class="btn btn-yellow" type="submit" value="Save">
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-md-8">
                <div class="panel panel-dark">
                    <div class="panel-heading">
                        <h3 class="panel-title">Connect server to War Room</h3>
                    </div>

                    {{ Form::token() }}

                    <div class="panel-body">

                        <div class="strip">
                            <p>Preparing your server</p>
                        </div>

                        <table class="table">
                            <tr>
                                <td width="80">Step 1</td>
                                <td>Download the ALiVE version of @Arma2Net</td>
                                <td><a class="btn btn-yellow" href="{{ URL::to('/') }}/downloads/@Arma2NET.zip"><i class="fa fa-download"></i> Download</a></td>
                            </tr>
                            <tr>
                                <td>Step 2</td>
                                <td>Place the @Arma2NET mod in your server mod folder.</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 3</td>
                                <td>Add @Arma2NET mod to your server startup parameters.</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 4</td>
                                <td>Download the alive.cfg for your group</td>
                                <td><a class="btn btn-yellow" href="{{ URL::to('admin/server/config') }}/{{ $clan->id }}"><i class="fa fa-download"></i> Download</a></td>
                            </tr>
                            <tr>
                                <td>Step 5</td>
                                <td>Copy the alive.cfg to C:\Users\USERNAME\AppData\Local\ALiVE - you may need to create the directory yourself.</td>
                                <td></td>
                            </tr>
                        </table>

                        <div class="strip">
                            <p>Validate setup</p>
                        </div>

                        <table class="table">
                            <tr>
                                <td width="80">Step 1</td>
                                <td>Download and install BareTail (log monitor)</td>
                                <td><a class="btn btn-yellow" target="_blank" href="http://www.baremetalsoft.com/baretail"><i class="fa fa-download"></i> Download</a></td>
                            </tr>
                            <tr>
                                <td>Step 2</td>
                                <td>Launch @Arma2Net/arma2netexplorer.exe</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 3</td>
                                <td>Click Load Addins</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 4</td>
                                <td>In baretail open C:\Users\USERNAME\AppData\Local\arma2net\arma2net.log</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 5</td>
                                <td>Check that arma2net has initialized without error</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 6</td>
                                <td>In arma2netexplorer click List Addins</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 7</td>
                                <td>Make sure that SendJSON is listed as an Addins</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 8</td>
                                <td>In arma2netexplorer type ServerName</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 9</td>
                                <td>It should return your machine name</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 10</td>
                                <td>type in SendJSON ["POST","events","{"hello":"world"}"]</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 11</td>
                                <td>It should return a message from the couchDB service stating OK with a UID</td>
                                <td></td>
                            </tr>
                        </table>

                        <div class="strip">
                            <p>Running Arma 3</p>
                        </div>

                        <table class="table">
                            <tr>
                                <td width="80">Step 1</td>
                                <td>Launch Arma3server.exe with the @Arma2Net and @ALiVE in the mod line</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 2</td>
                                <td>Launch your arma3.exe as normal</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 3</td>
                                <td>Run any MP mission on your dedicated local server and connect with your client</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Step 4</td>
                                <td>Go to alivemod.com warroom, under Recent Operations or Data Feed you should see a message stating your mission was launched.</td>
                                <td></td>
                            </tr>
                        </table>

                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

@stop
