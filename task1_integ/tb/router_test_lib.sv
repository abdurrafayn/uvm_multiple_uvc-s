class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    function new(string name="base_test", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    router_tb inst_tb;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         uvm_config_wrapper::set(this, "inst_tb.environment.agent.sequencer.run_phase",
                                "default_sequence",
                                yapp_5_packets::get_type());

        // inst_tb = new("inst_tb", this);
        inst_tb = router_tb::type_id::create("inst_tb", this);
        uvm_config_int::set( this, "*", "recording_detail", 1);
        `uvm_info("test_phase","Build phase of test is executing", UVM_HIGH);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

        function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Simulation in Test class", UVM_HIGH);
        
    endfunction

    task run_phase(uvm_phase phase);
        uvm_objection obj = phase.get_objection(); 
        obj.set_drain_time(this, 200ns);

    endtask

    function void check_phase(uvm_phase phase);
        check_config_usage();
    endfunction
endclass //className extends superClass


// //base_test p1;
// class test2 extends base_test;
//     `uvm_component_utils(test2)

//    function new(string name="test2", uvm_component parent);
//         super.new(name, parent);
//     endfunction //new()

// endclass //className extends superClass

// class short_packet_test extends base_test;

//     `uvm_component_utils(short_packet_test)
    
//     function new(string name="short_packet_test", uvm_component parent);
//         super.new(name, parent);
//     endfunction 


//     function void build_phase(uvm_phase phase);
//         set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
//         super.build_phase(phase);
//     endfunction

// endclass

// class set_config_test extends base_test;

//     `uvm_component_utils(set_config_test)

//     function new(string name="set_config_test", uvm_component parent);
//         super.new(name, parent);
//     endfunction 

//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
//         uvm_config_int::set(this,"inst_tb.environment.agent", "is_active", UVM_PASSIVE);
//     endfunction

// endclass

// class incr_paylaod_test extends base_test;

//     `uvm_component_utils(incr_paylaod_test)

//     function new(string name="incr_paylaod_test", uvm_component parent);
//         super.new(name, parent);
//     endfunction 

//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
       
//         uvm_config_wrapper::set(this, "inst_tb.environment.agent.sequencer.run_phase",
//                        "default_sequence",
//                        yapp_incr_payload_seq::get_type());
//     endfunction

// endclass
 

// class exhaustive_test extends base_test;

//     `uvm_component_utils(exhaustive_test)

//     function new(string name="exhaustive_test", uvm_component parent);
//         super.new(name, parent);
//     endfunction 

//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
//         set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
//         uvm_config_wrapper::set(this, "inst_tb.environment.agent.sequencer.run_phase",
//                        "default_sequence",
//                        yapp_exhaustive_seq::get_type());
//     endfunction
// endclass


// class new_test012 extends base_test;

//     `uvm_component_utils(new_test012)

//     function new(string name="new_test012", uvm_component parent);
//         super.new(name, parent);
//     endfunction 

//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
//         set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
//         uvm_config_wrapper::set(this, "inst_tb.environment.agent.sequencer.run_phase",
//                        "default_sequence",
//                        yapp_012_packets::get_type());
//     endfunction
// endclass

class simple_test extends base_test;

    `uvm_component_utils(simple_test)

    function new(string name="simple_test", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
        
        uvm_config_wrapper::set(this, "inst_tb.channel_?.rx_agent.sequencer.run_phase",
        "default_sequence", channel_rx_resp_seq::get_type());
        
        uvm_config_wrapper::set(this, "inst_tb.environment.agent.sequencer.run_phase",
                       "default_sequence",
                       yapp_012_packets::get_type());
        
        uvm_config_wrapper::set(this, "inst_tb.clock_and_reset.agent.sequencer.run_phase",
                       "default_sequence", clk10_rst5_seq::get_type());

    endfunction
endclass


class test_uvc_integration extends base_test;

`uvm_component_utils(test_uvc_integration)

    function new(string name="test_uvc_integration", uvm_component parent);
        super.new(name, parent);
    endfunction 

    function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
        
    uvm_config_wrapper::set(this, "inst_tb.channel_?.rx_agent.sequencer.run_phase",
        "default_sequence", channel_rx_resp_seq::get_type());
        
    uvm_config_wrapper::set(this, "inst_tb.environment.agent.sequencer.run_phase",
        "default_sequence", yapp_four::get_type());
        
    uvm_config_wrapper::set(this, "inst_tb.clock_and_reset.agent.sequencer.run_phase",
        "default_sequence", clk10_rst5_seq::get_type());

    uvm_config_wrapper::set(this, "inst_tb.hbus.masters[?].sequencer.run_phase",
        "default_sequence", hbus_small_packet_seq::get_type());

    endfunction: build_phase

endclass: test_uvc_integration