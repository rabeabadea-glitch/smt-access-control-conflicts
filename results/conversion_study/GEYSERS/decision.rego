package thesis

valid if {
    is_object(input)
    count(input) == 2
    is_string(input["a_1d89fbbb6c7cfd6c"])
    input["a_1d89fbbb6c7cfd6c"] in {"http://geysers.eu/upperlicl/resource/resource-type/RP-Operation-Info", "http://geysers.eu/upperlicl/resource/resource-type/VI", "http://geysers.eu/upperlicl/resource/resource-type/VI-Request", "http://geysers.eu/upperlicl/resource/resource-type/VLink", "http://geysers.eu/upperlicl/resource/resource-type/VNode", "http://geysers.eu/upperlicl/resource/resource-type/VNode-Info", "http://geysers.eu/upperlicl/resource/resource-type/VNode-Monitor-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR", "http://geysers.eu/upperlicl/resource/resource-type/VR-IT", "http://geysers.eu/upperlicl/resource/resource-type/VR-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR-Mon-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR-Operation-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR-Power-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR-RP", "http://geysers.eu/upperlicl/resource/resource-type/VR-RP-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR-State-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR-Status-Info", "http://geysers.eu/upperlicl/resource/resource-type/VR-Sync-Info", "__OTHER__"}
    is_string(input["a_5ce35a229c45e30b"])
    input["a_5ce35a229c45e30b"] in {"CCI:Configure", "CCI:Monitor", "CCI:Sync-Request", "MLI:Decommission-VI", "MLI:Get-SLA-Offer", "MLI:Instantiate-VI", "MLI:Query-VI-Request-Status", "MLI:ReplanningVI:Add-VLink", "MLI:ReplanningVI:Add-VR-IT", "MLI:ReplanningVI:Delete-VLink", "MLI:ReplanningVI:Delete-VR-IT", "MLI:ReplanningVI:Modify-Time", "MLI:ReplanningVI:Modify-VLink", "MLI:ReplanningVI:Modify-VR-IT", "MLI:Request-VI", "MLI:Sign-SLA-Offer", "ROS:Notify-RP-Operation", "ROS:Notify-VR-Info", "ROS:Notify-VR-Operation", "SLI:Add-VirtualNetworkIf", "SLI:Create-StorageImage", "SLI:Decommission-VR-IT", "SLI:Get-Available-VR-Pool-IT", "SLI:Instantiate-VR-IT", "SLI:Monitor-VR-Info", "SLI:Operate-VR", "SLI:Remove-StorageImage", "SLI:Remove-VirtualNetworkIf", "SLI:Subscribe-VR-Monitoring", "SLI:Unsubscribe-VR-Monitoring", "__OTHER__"}
    c0
}

matched contains "RPSlist::Permit" if { valid; rule_0 }
matched contains "RPSlist::Deny" if { valid; rule_1 }
permit if { valid; rule_0 }
default permit := false
deny if { valid; rule_1 }
default deny := false

decision := "InvalidRequest" if { not valid }
decision := "Conflict" if { valid; permit; deny }
decision := "Permit" if { valid; permit; not deny }
decision := "Deny" if { valid; deny; not permit }
decision := "NotApplicable" if { valid; not permit; not deny }
allow := decision == "Permit"
result := {"decision": decision, "matched": sort(matched), "allow": allow}
