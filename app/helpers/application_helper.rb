module ApplicationHelper
  include Pagy::Frontend

  def tailwind_pagy_nav(pagy)
    html = pagy_nav(pagy, link_extra: 'data-turbo-frame="comments_pagination"')
    html.gsub!('<nav class="pagy nav"', '<nav class="flex justify-center mt-4 space-x-2"')
    html.gsub!('<a', '<a class="px-3 py-1 rounded-md bg-[#2f3136] text-white hover:bg-[#7289da] transition"')
    html.gsub!('class="current"', 'class="px-3 py-1 rounded-md bg-[#7289da] text-white font-bold"')
    html.html_safe
  end
end
