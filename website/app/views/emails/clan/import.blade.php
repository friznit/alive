<!DOCTYPE html>
<html lang="en-US">
	<head>
		<meta charset="utf-8">
	</head>
	<body>
		<h2>ALiVE War Room Clan XML import results</h2>

        <table class="table table-hover">
            <thead>
            <tr>
                <th>Username</th>
                <th>Email</th>
                <th>Password</th>
                <th>Created</th>
                <th>Details</th>
            </tr>
            </thead>
            <tbody>
            @foreach ($results as $member)
            <tr>
                <td>{{{ $member->username }}}</td>
                <?php
                $created = 'No';
                if($member->created){
                    $created = 'Yes';
                    ?>
                    <td>{{ $member->email }}</td>
                    <td>{{ $member->password }}</td>
                    <td>{{ $created }}</td>
                <?php
                }else{
                    ?>
                    <td></td>
                    <td></td>
                    <td>{{ $created }}</td>
                <?php
                }
                ?>
                <td>{{{ $member->reason }}}</td>

            </tr>
            @endforeach
            </tbody>
        </table>

    </body>
</html>