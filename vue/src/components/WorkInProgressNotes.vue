<template>
    <div class="work-in-proress-notes">
        <h1>WORK IN PROGRESS NOTES, TODOS, ECK SETERA</h1>
        <p id="wip-text">
            <br>
            TODO: make add teacher and student function use checkbox to add to student and teacher objects
            to the database.
            <br>
            TODO: the difficulty field for course has been replaced with class size, which justin seemed
            more interested in. Still need to change the business logic on SQLDAO to check how many students before
            adding more.
            <br>
            TODO: build on the extremely not at all finished "add homework" so that we can now add questions
            to a particular homework assignment
            <br>
            TODO: make the banners fit the page better, (sizing), they look good but sometimes are a weird
            shape and seem stretched
            <br>
            TODO: create new sidebars, we should have a user, teacher, and admin sidebar based on what justin said, I think?
            <br>
            TODO: make login gif larger and have the login fields super-imposed on it, so there is no
            scroll bar on home page
            <br>
            ADD to this obnoxious list


        </p>
    </div>
</template>

<script>
export default {
    name: "work-in-progress-notes"
}
</script>

<style>
#wip-text{
    font-size: 30px;
}
</style>