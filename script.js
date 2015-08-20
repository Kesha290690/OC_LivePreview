var previewLoad =
{
    get: function(product_id)
    {
        $.ajax({
            url     : 'index.php?route=product/product/getPreviewLoad',
            type    : 'post',
            data    : 'product_id=' + product_id,
            dataType: 'json',
            success: function(json) {
                console.log(json)
                var totalReting = _.pluck(json.review,'rating');
                var totalRetingInt = totalReting.map(function (x) {
                    return parseInt(x, 10);
                });
                var sum = _.reduce(totalRetingInt, function(memo, num){ return (memo + num); }, 0)/json.total_review;
                var totalSum = Math.round(sum);
                var template = _.template($('#preview-block').html());
                $("body").after(template(
                    {
                        product_id      : json.product_id,
                        name            : json.name,
                        price           : json.price,
                        image           : json.image,
                        quantity        : json.quantity,
                        rating          : totalSum,
                        option_name     : json.option,
                        total_review    : json.total_review,
                        attribute       : json.attribute,
                        reting_review   : json.review,
                        option_quantity : _.pluck(json.option,'option_quantity'),
                    }
                ));

                $('.my-product-preview').show(400);

                previewLoad.background();
            }
        })
    },
    add: function(){

    },
    background: function(){
        var docHeight = $(document).height();
        $("body").append("<div id='overlay'></div>");
        $("#overlay")
            .height(docHeight)
            .css({
                'opacity' : 0.4,
                'position': 'absolute',
                'top': 0,
                'left': 0,
                'background-color': 'black',
                'width': '100%',
                'z-index': 7
            });
    },
    close: function(){
            $('.my-product-preview').remove();
            $('#overlay').detach();

    }
};