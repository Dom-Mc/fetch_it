class Service {
  constructor(jsonData){
    this.id = jsonData.id;
    this.service_name = jsonData.service_name;
    this.description = jsonData.description;
    this.start_time = jsonData.start_time;
    this.end_time = jsonData.end_time;
  }
  displayService(){
    const html = [
      '<div class="flex success">',
      `<h2>${this.service_name}</h2>`,
      '<ul>',
      `<li><b>Service Name:</b> ${this.service_name}</li>`,
      `<li><b>Service Description:</b> ${this.description}</li>`,
      `<li><b>Service Start Time:</b> ${this.start_time}</li>`,
      `<li><b>Service End Time:</b> ${this.end_time}</li>`,
      `<a href="/services" class="btn btn-primary">View Services</a>`,
      '</ul>',
      '</div>'
    ].join('')
    return html;
  }
}//end Service

$(document).on('turbolinks:load', function() {

  $('#new_service').submit(function(event){

    event.preventDefault();
    $('.alert.alert-danger').remove();

    $.ajax({
      url: this.action,
      data: $(this).serialize(),
      dataType: "json",
      type: this.method,

      success: function(response){
        const service = new Service(response);
        $("form").html(service.displayService());
        $(".page-title").html("Service Created")
      },

      error: function(errorResponse){
        const error = $.parseJSON(errorResponse.responseText);
        const html = [
          '<div class="alert alert-danger alert-dismissible fade in" role="alert">',
          '<button type="button" class="close" data-dismiss="alert" aria-label="Close">',
          '<span aria-hidden="true">×</span>',
          '</button>',
          '<div class="flex">',
          '<h4>Please fix the following errors:</h4>',
          '<ul class=js-error>',
        ]

        for (const message in error) {
          html.push(`<li>${error[message]}</li>`);
        }
        html.push(
                  '</ul>',  //.js-error
                  '</div>', //.alert
                  '</div>'  //.flex
                );

        // NOTE: place error message above the form
        $(".container.service.form").before(html.join(''));
      },// end error

      complete: function(){
        // NOTE: enable submit button after preventDefault() and automatically scroll to top of window to view possible errors
        $('input[type="submit"]').prop('disabled', false);
        $( "#services-new" ).scrollTop( 0 );
      }

    });//end ajax()

  });//end submit()
});//end on('turbolinks:load')
