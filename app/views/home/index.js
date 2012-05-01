$('tr#_<%= @variant.product_id %> form input.variant').remove();

<% if @variant %>
$('tr#_<%= @variant.product_id %> span').text('<%= @variant.price %>');
<% if @variant.available_for_order? %>
$('tr#_<%= @variant.product_id %> form').append('<input type="hidden" name="variants[<%= @variant.id %>]" value="1" class="variant" />');
$('tr#_<%= @variant.product_id %> form a').show();
<% else %>
$('tr#_<%= @variant.product_id %> form a').hide();
<% end %>
<% end %>