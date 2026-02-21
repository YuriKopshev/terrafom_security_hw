[webservers]
%{~ for idx, vm in web_vms ~}
${vm.network_interface[0].nat_ip_address} ansible_host=${vm.network_interface[0].nat_ip_address} fqdn=${vm.fqdn}
%{~ endfor ~}

[databases]
%{~ for idx, vm in db_vms ~}
${vm.network_interface[0].nat_ip_address} ansible_host=${vm.network_interface[0].nat_ip_address} fqdn=${vm.fqdn}
%{~ endfor ~}

[storage]
${storage.network_interface[0].nat_ip_address} ansible_host=${storage.network_interface[0].nat_ip_address} fqdn=${storage.fqdn}

