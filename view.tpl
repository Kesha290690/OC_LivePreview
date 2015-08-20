<script type="text/html" id="preview-block">
    <div class="my-product-preview">
        <button onclick="previewLoad.close()" class="my-preview-close" style="z-index:9;"><span class="glyphicon glyphicon-remove"></span></button>
        <h3 class="my-heanding-product"><p><span class="my-heanding-product-left"></span><%= name %><span
                        class="my-heanding-product-right"></span></p></h3>
        <div style="width:60%; float:left;">
            <div class="my-empty-block-2">
                <img src="image/<%= image %>">
            </div>
        </div>
        <div style="width:40%; float:left;">
            <div class="my-product-description">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="my-product-description-block">
                            <div id="pre-product">
                            <div class="my-product-discription-header">
                                <p class="my-product-articul"><span>Артикул: 29837</span><br>
                                    <%  if(quantity  > 0){ %>
                                    Есть в наличии
                                    <% } else { %>
                                    Нету в наличии
                                    <% } %>
                                </p>
                                <div class="my-product-rating-two" style="text-align:right; padding-top:10px;">
                                    <p class="my-product-review-num">
                                        <% if(isNaN(rating)) { %>
                                        <span class="my-review-rating-bad"></span>
                                        <span class="my-review-rating-bad"></span>
                                        <span class="my-review-rating-bad"></span>
                                        <span class="my-review-rating-bad"></span>
                                        <span class="my-review-rating-bad"></span>
                                        <% } else { %>
                                        <% for(var i = 1; i <= 5; i++) { %>
                                        <% if(rating < i) { %>
                                        <span class="my-review-rating-bad"></span>
                                        <% } else { %>
                                        <span class="my-review-rating"></span>
                                        <% } %>
                                        <% } %>
                                    <% } %>
                                        <span class="my-review-rating-count"><%= total_review %> отзыва</span></p>
                                </div>
                            </div>
                            <div class="my-product-manufactur">
                                <img src="catalog/view/theme/cosmos/image/manufaktur.gif">

                                <div class="my-product-manufactur-disc">
                                    <p>Цвет: <span class="my-product-item-color"></span></p>
                                    <% for(var key in attribute) { %>
                                    <% var valAt = attribute[key]; %>
                                    <p><%= valAt.attribute_name %>: <span><%= valAt.attribute_text %></span></p>
                                    <% } %>
                                </div>
                            </div>
                            <div class="my-product-size">
                                <p>Выберите размер</p>


                                    <div class="form-group required">
                                         <div id="input-option228">
                                            <% for (var key in option_name) { %>
                                                <% var val = option_name[key]; %>
                                                    <% if(val.option_quantity > 0) { %>
                                                    <input class="pre-option-value" style="display: none" name="option[<%= val.product_option_id %>]" id="pre<%= val.product_option_value_id %>" type="radio" value="<%= val.product_option_value_id %>">
                                                    <label for="pre<%= val.product_option_value_id %>" class="my-product-size-yes"><%= val.option_name %></label>
                                                    <% } else { %>
                                                    <label for="" class="my-product-size-no"><%= val.option_name %></label>
                                                    <% } %>
                                            <% } %>
                                         </div>
                                    </div>

                                <button id="view-size-block" class="my-product-size-button">Определить размер</button>
                            </div>
                            <div class="my-product-button-block">
                                <p>
                                    <span class="two-new"></span><span class="two-old"></span>
                                    <span class="two-new"><%= price %></span>
                                </p>
                                <div class="form-group" style="margin: 0px;">
                                    <input style="display: none" type="text" name="quantity" value="1" size="2" id="input-quantity" class="form-control" />
                                    <input type="hidden" name="product_id" value="<%= product_id %>" />
                                    <button style="z-index: 100;" type="button" id="preview-button-cart" class="my-product-button-buy">Купить</button>
                                    <button onclick="compare.add('<%= product_id %>');" class="my-product-button-compire"></button>
                                    <button onclick="wishlist.add('<%= product_id %>');" class="my-product-button-like"></button>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</script>
<script>
    $(document).delegate('#preview-button-cart','click', function(){
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#pre-product input[type=\'text\'], #pre-product input[type=\'hidden\'], #pre-product input[type=\'radio\']:checked, #pre-product input[type=\'checkbox\']:checked, #pre-product select, #pre-product textarea'),
            dataType: 'json',
            success: function(json) {

                if(json['error']) {
                    function backgraundBlack2() {
                        var docHeight = $(document).height();
                        $('body').append("<div id='overlay2'></div>");
                        $("#overlay2")
                                .height(docHeight)
                                .css({
                                    'opacity' : 0.4,
                                    'position': 'absolute',
                                    'top': 0,
                                    'left': 0,
                                    'background-color': 'black',
                                    'width': '100%',
                                    'z-index': 9
                                });
                    };

                    $('#view-size-block').before('<div style="color: red;font-size: 18px">Выберите размер!</div>');

                }

                if (json['success']) {
                    $('.my-header-cart-text').html('<span class="my-header-cart-text-count">' + json['count'] + ' Товаров</span><br><span class="my-header-cart-text-price">' + json['total_price'] + '</span>');
                    $('.test-madal').append('<span>' + json['count'] + '</span>');

                    $('.my-product-preview').remove();
                    $("#overlay").detach();

                    $('#cart > .my-new-modal-block').load('index.php?route=common/modal_cart/info #cart > .my-new-modal-block > *');
                    $('html, body').animate({scrollTop: 0}, 'slow');

                }
            }
        })
    })
</script>