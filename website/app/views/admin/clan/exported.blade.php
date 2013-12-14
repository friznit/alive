@if (Sentry::check())

<?xml version="1.0"?>
<!DOCTYPE squad SYSTEM "squad.dtd">
<?xml-stylesheet href="squad.xsl?" type="text/xsl"?>
<squad nick="{{{ $clan->tag }}}">
    <name>{{{ $clan->name }}}</name>
    <email></email>
    <web></web>
    <picture></picture>
    <title>{{{ $clan->title }}}</title>
    @foreach ($results as $member)
    <?php
    if($member->a2_id != ''){
    ?>
<member id="{{{ $member->a2_id }}}" nick="{{{ $member->username }}}">
        <name>{{{ $member->username }}}</name>
        <email>{{{ $member->email }}}</email>
        <icq></icq>
        <remark>{{{ $member->remark }}}</remark>
    </member>
    <?php
    }
    ?>
    <?php
    if($member->a3_id != ''){
    ?>
<member id="{{{ $member->a3_id }}}" nick="{{{ $member->username }}}">
        <name>{{{ $member->username }}}</name>
        <email>{{{ $member->email }}}</email>
        <icq></icq>
        <remark>{{{ $member->remark }}}</remark>
    </member>
    <?php
    }
    ?>
    @endforeach
</squad>

@endif