(function($) {
    function init() {
        $("#transitionEffect").fadeTransition({pauseTime: 4000,
            transitionTime: 500,
            ignore: "#introslide",
            delayStart: 0,
            manualNavigation: false,
            pauseOnMouseOver: true,
            createNavButtons: true});
    }

    $(document).ready(init);
})(jQuery);