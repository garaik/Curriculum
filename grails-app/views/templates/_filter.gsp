<form action="${createLink()}" method="GET" id="filterForm">
    <div class="small-12 columns">
        <div class="row collapse">
            <div class="small-10 columns">
                <input type="text" name="filter" placeholder="keresés..." value="${pagination?.filter}">
            </div>
            <div class="small-2 columns">
                <a href="#" class="button postfix radius" onclick="$('#filterForm').submit()"><i class="icon-search"></i> Keresés</a>
            </div>
        </div>
    </div>
</form>
