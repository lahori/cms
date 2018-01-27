module SystemsHelper

  def system_tree (systems)
    system_jstree = Array.new
#    system_jstree[0] = 'system root node'
    puts "############### Heper Method #########################"

    systems.each do |system|
      puts system.name
      puts "############### Heper Method #########################"

      tree_node = Hash.new
      tree_node['id'] = system.id
      tree_node['text'] = system.name
      tree_node['state'] = {'opened' => false, 'selected' => false}
      node_url = '/systems/' + system.id.to_s
      tree_node['a_attr'] = {'href' => node_url}

      ## Add each Appliance found in the system to a hash
      ctx_children = Array.new

      appliances_node = Hash.new
      appliances_node['id'] = system.id.to_s + '-appliance'
      appliances_node['text'] = 'Appliance'
      appliances_node['state'] = {'opened' => false, 'selected' => false}
      appliances_url = '/systems/' + system.id.to_s + '/appliances/'
      appliances_node['a_attr'] = {'href' => appliances_url}

      ctx_children.push(appliances_node)

      ctx_children.push('Configuration')
      ctx_children.push('Storage')
      ctx_children.push('Network')
      ctx_children.push('Clients')

      tree_node['children'] = ctx_children
      system_jstree.push(tree_node)

    end

    return JSON.pretty_generate system_jstree

  end

end
