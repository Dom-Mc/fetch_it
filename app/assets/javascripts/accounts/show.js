$(document).on('turbolinks:load', function() {

  $("#search-form").submit(function(event){

    const searchInput = $('#search').val();
    const orderHistoryPath = "<%= account_orders_path(@user_account) %>";
    const outputHtml = [
          '<div class="alert panel panel-default alert-dismissible">',
          '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>'
        ];
    event.preventDefault();

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function(response){
        const urlPath = `/account/${response.account.slug}/orders/${response.id}`;

        outputHtml.push(
            `<h1>Order #${response.id}</h1>`,
            '<ul>',
            `<li>Number of items: ${response.number_of_items}</li>`,
            `<li>Shipping Reference: ${response.shipping_reference || ''}</li>`,
            `<li>Pickup Date: ${response.pickup_date}</li>`,
            `<li>Shipper's Name: ${response.shipper.first_name || ''} ${response.shipper.last_name}</li>`,
            `<li>Recipient's Name: ${response.recipient.first_name} ${response.recipient.last_name}</li>`,
            `<a href="${urlPath}">More info</a>`,
            '</ul>'
                  );
      },//end success

      error: function(error){
          outputHtml.push(
              `<h3>Order #${searchInput} could not be found</h3>`,
              '<p>Please check your ',
              `<a href="${orderHistoryPath}">order history</a> `,
              'and try again.</p>'
          );
      },

      complete: function(){
        $('#search').val('');
        $('input[type="submit"]').prop('disabled', false);
        outputHtml.push('</div>');
        $('.js-searchResults').html(outputHtml.join(''));
      }

    });//end ajax()
  });//end submit()
});//end on('turbolinks:load')
