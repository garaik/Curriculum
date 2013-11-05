function setPosition(){
    var selectedPosition = $('#gapFillExerciseTextarea').selection('getPos');
    var selectedText = $('#gapFillExerciseTextarea').selection('get');
    $('#positionStartValue').val(selectedPosition.start)
    $('#positionEndValue').val(selectedPosition.end)
    $('#positionTextValue').val(selectedText)
}


function hiddenStringsShow(){
    $('#gapFillExerciseTextarea').attr('readonly',true);
    $('#gapFillExerciseStringsFormContainer').attr('hidden',false);
    $('#gapFillTextSaveButton').attr('hidden',true);
    $('#isSavedText').val('true');

}

$(function() {
    $('#gapFillSelectMode').change(function(){
    $('.gapFillExerciseStringAlternativesDiv').toggle();
  });
});

