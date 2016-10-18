/**
 * MIT License
 *
 * Copyright (c) 2016 sashimi
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
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
