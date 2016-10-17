$(function () {
    var pageItems = $(".page-item");
    var numPages = pageItems.size();

    var pageNumber = 0;
    var query = location.search || "";
    var m = query.match(/^\?page=(\d{1,4})$/);
    if (m && m[1] >= 0 && m[1] < numPages) {
        pageNumber = Number(m[1]);
    }

    pageItems.hide();
    $("#page-" + pageNumber).show();

    if (pageNumber - 1 >= 0) {
        $(".pager-prev a").attr("href", location.pathname + "?page=" + (pageNumber - 1));
    } else {
        $(".pager-prev a").css("visibility", "hidden");
    }
    if (pageNumber + 1 < numPages) {
        $(".pager-next a").attr("href", location.pathname + "?page=" + (pageNumber + 1));
    } else {
        $(".pager-next a").css("visibility", "hidden");
    }
});
