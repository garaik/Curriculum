<g:if test="${pagination.first()}">
    <a href="#" class="button small radius disabled" onclick="return false;"><i class="icon-step-backward"></i></a>
</g:if>
<g:else>
    <a href="${createLink(params: pagination.linkParams + [page: 1])}" class="button small radius blue"><i class="icon-step-backward"></i></a>
</g:else>

<g:if test="${pagination.previous()}">
    <a href="${createLink(params: pagination.linkParams + [page: pagination.page - 1])}" class="button small radius blue"><i class="icon-backward"></i></a>
</g:if>
<g:else>
    <a href="#" class="button small radius disabled" onclick="return false;"><i class="icon-backward"></i></a>
</g:else>

&nbsp;
${pagination.pageFrom()}-${pagination.pageUntil(count)} (${count})
                &nbsp;

<g:if test="${pagination.next(count)}">
    <a href="${createLink(params: pagination.linkParams + [page: pagination.page + 1])}" class="button small blue radius"><i class="icon-forward"></i></a>
</g:if>
<g:else>
    <a href="" class="button small disabled radius"><i class="icon-forward"></i></a>
</g:else>

<g:if test="${pagination.last(count)}">
    <a href="" class="button small disabled radius"><i class="icon-step-forward"></i></a>
</g:if>
<g:else>
    <a href="${createLink(params: pagination.linkParams + [page: pagination.lastPage(count)])}" class="button small blue radius"><i class="icon-step-forward"></i></a>
</g:else>
