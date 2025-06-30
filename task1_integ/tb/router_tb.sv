class router_tb extends uvm_env;
    
`uvm_component_utils(router_tb)

    

    function new(string name ="router_tb", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    // multiple UVCs (handles of UVCs)
    yapp_env environment;
    channel_env channel_0;
    channel_env channel_1;
    channel_env channel_2;
    hbus_env hbus;
    clock_and_reset_env clock_and_reset;

    function void build_phase(uvm_phase phase);
    
        // environment = new("environment", this);
        super.build_phase(phase);
        `uvm_info("build_phase","Build base of base test is executing", UVM_HIGH);

        environment = yapp_env::type_id::create("environment", this);
        // using configuration set method to set the channel id

        uvm_config_int::set(this, "channel_0", "channel_id", 0);
        uvm_config_int::set(this, "channel_1", "channel_id", 1);
        uvm_config_int::set(this, "channel_2", "channel_id", 2);
        uvm_config_int::set(this, "hbus", "num_masters", 1);
        uvm_config_int::set(this, "hbus", "num_slaves", 0);

        uvm_config_int::set(this, "clock_and_reset", "channel_id", 2);

        channel_0 = channel_env::type_id::create("channel_0", this);
        channel_1 = channel_env::type_id::create("channel_1", this);
        channel_2 = channel_env::type_id::create("channel_2", this);
        hbus = hbus_env::type_id::create("hbus", this);
        clock_and_reset = clock_and_reset_env::type_id::create("clock_and_reset", this);

    endfunction: build_phase

endclass: router_tb