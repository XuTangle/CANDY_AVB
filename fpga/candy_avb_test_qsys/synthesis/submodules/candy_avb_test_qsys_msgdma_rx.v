// candy_avb_test_qsys_msgdma_rx.v

// This file was auto-generated from altera_msgdma_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module candy_avb_test_qsys_msgdma_rx (
		output wire [23:0] mm_write_address,                           //                mm_write.address
		output wire        mm_write_write,                             //                        .write
		output wire [3:0]  mm_write_byteenable,                        //                        .byteenable
		output wire [31:0] mm_write_writedata,                         //                        .writedata
		input  wire        mm_write_waitrequest,                       //                        .waitrequest
		output wire [24:0] descriptor_read_master_address,             //  descriptor_read_master.address
		output wire        descriptor_read_master_read,                //                        .read
		input  wire [31:0] descriptor_read_master_readdata,            //                        .readdata
		input  wire        descriptor_read_master_waitrequest,         //                        .waitrequest
		input  wire        descriptor_read_master_readdatavalid,       //                        .readdatavalid
		output wire [24:0] descriptor_write_master_address,            // descriptor_write_master.address
		output wire        descriptor_write_master_write,              //                        .write
		output wire [3:0]  descriptor_write_master_byteenable,         //                        .byteenable
		output wire [31:0] descriptor_write_master_writedata,          //                        .writedata
		input  wire        descriptor_write_master_waitrequest,        //                        .waitrequest
		input  wire [1:0]  descriptor_write_master_response,           //                        .response
		input  wire        descriptor_write_master_writeresponsevalid, //                        .writeresponsevalid
		input  wire        clock_clk,                                  //                   clock.clk
		input  wire        reset_n_reset_n,                            //                 reset_n.reset_n
		input  wire [31:0] csr_writedata,                              //                     csr.writedata
		input  wire        csr_write,                                  //                        .write
		input  wire [3:0]  csr_byteenable,                             //                        .byteenable
		output wire [31:0] csr_readdata,                               //                        .readdata
		input  wire        csr_read,                                   //                        .read
		input  wire [2:0]  csr_address,                                //                        .address
		input  wire [2:0]  prefetcher_csr_address,                     //          prefetcher_csr.address
		input  wire        prefetcher_csr_read,                        //                        .read
		input  wire        prefetcher_csr_write,                       //                        .write
		input  wire [31:0] prefetcher_csr_writedata,                   //                        .writedata
		output wire [31:0] prefetcher_csr_readdata,                    //                        .readdata
		output wire        csr_irq_irq,                                //                 csr_irq.irq
		input  wire [31:0] st_sink_data,                               //                 st_sink.data
		input  wire        st_sink_valid,                              //                        .valid
		output wire        st_sink_ready,                              //                        .ready
		input  wire        st_sink_startofpacket,                      //                        .startofpacket
		input  wire        st_sink_endofpacket,                        //                        .endofpacket
		input  wire [1:0]  st_sink_empty,                              //                        .empty
		input  wire [5:0]  st_sink_error                               //                        .error
	);

	wire          prefetcher_internal_descriptor_write_dispatcher_source_valid; // prefetcher_internal:st_src_descr_valid -> dispatcher_internal:snk_descriptor_valid
	wire  [127:0] prefetcher_internal_descriptor_write_dispatcher_source_data;  // prefetcher_internal:st_src_descr_data -> dispatcher_internal:snk_descriptor_data
	wire          prefetcher_internal_descriptor_write_dispatcher_source_ready; // dispatcher_internal:snk_descriptor_ready -> prefetcher_internal:st_src_descr_ready
	wire          dispatcher_internal_response_source_valid;                    // dispatcher_internal:src_response_valid -> prefetcher_internal:st_snk_valid
	wire  [255:0] dispatcher_internal_response_source_data;                     // dispatcher_internal:src_response_data -> prefetcher_internal:st_snk_data
	wire          dispatcher_internal_response_source_ready;                    // prefetcher_internal:st_snk_ready -> dispatcher_internal:src_response_ready
	wire          dispatcher_internal_write_command_source_valid;               // dispatcher_internal:src_write_master_valid -> write_mstr_internal:snk_command_valid
	wire  [255:0] dispatcher_internal_write_command_source_data;                // dispatcher_internal:src_write_master_data -> write_mstr_internal:snk_command_data
	wire          dispatcher_internal_write_command_source_ready;               // write_mstr_internal:snk_command_ready -> dispatcher_internal:src_write_master_ready
	wire          write_mstr_internal_response_source_valid;                    // write_mstr_internal:src_response_valid -> dispatcher_internal:snk_write_master_valid
	wire  [255:0] write_mstr_internal_response_source_data;                     // write_mstr_internal:src_response_data -> dispatcher_internal:snk_write_master_data
	wire          write_mstr_internal_response_source_ready;                    // dispatcher_internal:snk_write_master_ready -> write_mstr_internal:src_response_ready

	dispatcher #(
		.MODE                        (2),
		.RESPONSE_PORT               (1),
		.DESCRIPTOR_INTERFACE        (1),
		.DESCRIPTOR_FIFO_DEPTH       (128),
		.ENHANCED_FEATURES           (0),
		.DESCRIPTOR_WIDTH            (128),
		.DESCRIPTOR_BYTEENABLE_WIDTH (16)
	) dispatcher_internal (
		.clk                     (clock_clk),                                                                                                                                                                                                                                                             //                clock.clk
		.reset                   (~reset_n_reset_n),                                                                                                                                                                                                                                                      //          clock_reset.reset
		.csr_writedata           (csr_writedata),                                                                                                                                                                                                                                                         //                  CSR.writedata
		.csr_write               (csr_write),                                                                                                                                                                                                                                                             //                     .write
		.csr_byteenable          (csr_byteenable),                                                                                                                                                                                                                                                        //                     .byteenable
		.csr_readdata            (csr_readdata),                                                                                                                                                                                                                                                          //                     .readdata
		.csr_read                (csr_read),                                                                                                                                                                                                                                                              //                     .read
		.csr_address             (csr_address),                                                                                                                                                                                                                                                           //                     .address
		.src_response_data       (dispatcher_internal_response_source_data),                                                                                                                                                                                                                              //      Response_Source.data
		.src_response_valid      (dispatcher_internal_response_source_valid),                                                                                                                                                                                                                             //                     .valid
		.src_response_ready      (dispatcher_internal_response_source_ready),                                                                                                                                                                                                                             //                     .ready
		.snk_descriptor_data     (prefetcher_internal_descriptor_write_dispatcher_source_data),                                                                                                                                                                                                           //      Descriptor_Sink.data
		.snk_descriptor_valid    (prefetcher_internal_descriptor_write_dispatcher_source_valid),                                                                                                                                                                                                          //                     .valid
		.snk_descriptor_ready    (prefetcher_internal_descriptor_write_dispatcher_source_ready),                                                                                                                                                                                                          //                     .ready
		.src_write_master_data   (dispatcher_internal_write_command_source_data),                                                                                                                                                                                                                         // Write_Command_Source.data
		.src_write_master_valid  (dispatcher_internal_write_command_source_valid),                                                                                                                                                                                                                        //                     .valid
		.src_write_master_ready  (dispatcher_internal_write_command_source_ready),                                                                                                                                                                                                                        //                     .ready
		.snk_write_master_data   (write_mstr_internal_response_source_data),                                                                                                                                                                                                                              //  Write_Response_Sink.data
		.snk_write_master_valid  (write_mstr_internal_response_source_valid),                                                                                                                                                                                                                             //                     .valid
		.snk_write_master_ready  (write_mstr_internal_response_source_ready),                                                                                                                                                                                                                             //                     .ready
		.descriptor_write        (1'b0),                                                                                                                                                                                                                                                                  //          (terminated)
		.descriptor_waitrequest  (),                                                                                                                                                                                                                                                                      //          (terminated)
		.descriptor_writedata    (128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000),                                                                                                                                 //          (terminated)
		.descriptor_byteenable   (16'b0000000000000000),                                                                                                                                                                                                                                                  //          (terminated)
		.mm_response_waitrequest (),                                                                                                                                                                                                                                                                      //          (terminated)
		.mm_response_byteenable  (4'b0000),                                                                                                                                                                                                                                                               //          (terminated)
		.mm_response_address     (1'b0),                                                                                                                                                                                                                                                                  //          (terminated)
		.mm_response_readdata    (),                                                                                                                                                                                                                                                                      //          (terminated)
		.mm_response_read        (1'b0),                                                                                                                                                                                                                                                                  //          (terminated)
		.src_read_master_data    (),                                                                                                                                                                                                                                                                      //          (terminated)
		.src_read_master_valid   (),                                                                                                                                                                                                                                                                      //          (terminated)
		.src_read_master_ready   (1'b0),                                                                                                                                                                                                                                                                  //          (terminated)
		.snk_read_master_data    (256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000), //          (terminated)
		.snk_read_master_valid   (1'b0),                                                                                                                                                                                                                                                                  //          (terminated)
		.snk_read_master_ready   (),                                                                                                                                                                                                                                                                      //          (terminated)
		.csr_irq                 ()                                                                                                                                                                                                                                                                       //          (terminated)
	);

	altera_msgdma_prefetcher #(
		.ENHANCED_FEATURES          (0),
		.ENABLE_READ_BURST          (0),
		.MAX_READ_BURST_COUNT       (1),
		.MAX_READ_BURST_COUNT_WIDTH (1),
		.DATA_WIDTH                 (32),
		.DATA_BYTEENABLE_WIDTH      (4),
		.DESCRIPTOR_WIDTH           (128),
		.ADDRESS_WIDTH              (25),
		.RESPONSE_FIFO_DEPTH        (256),
		.RESPONSE_FIFO_DEPTH_LOG2   (8)
	) prefetcher_internal (
		.clk                         (clock_clk),                                                    //                              Clock.clk
		.reset                       (~reset_n_reset_n),                                             //                        Clock_reset.reset
		.mm_read_address             (descriptor_read_master_address),                               //             Descriptor_Read_Master.address
		.mm_read_read                (descriptor_read_master_read),                                  //                                   .read
		.mm_read_readdata            (descriptor_read_master_readdata),                              //                                   .readdata
		.mm_read_waitrequest         (descriptor_read_master_waitrequest),                           //                                   .waitrequest
		.mm_read_readdatavalid       (descriptor_read_master_readdatavalid),                         //                                   .readdatavalid
		.mm_write_address            (descriptor_write_master_address),                              //            Descriptor_Write_Master.address
		.mm_write_write              (descriptor_write_master_write),                                //                                   .write
		.mm_write_byteenable         (descriptor_write_master_byteenable),                           //                                   .byteenable
		.mm_write_writedata          (descriptor_write_master_writedata),                            //                                   .writedata
		.mm_write_waitrequest        (descriptor_write_master_waitrequest),                          //                                   .waitrequest
		.mm_write_response           (descriptor_write_master_response),                             //                                   .response
		.mm_write_writeresponsevalid (descriptor_write_master_writeresponsevalid),                   //                                   .writeresponsevalid
		.st_src_descr_data           (prefetcher_internal_descriptor_write_dispatcher_source_data),  // Descriptor_Write_Dispatcher_Source.data
		.st_src_descr_valid          (prefetcher_internal_descriptor_write_dispatcher_source_valid), //                                   .valid
		.st_src_descr_ready          (prefetcher_internal_descriptor_write_dispatcher_source_ready), //                                   .ready
		.st_snk_data                 (dispatcher_internal_response_source_data),                     //                      Response_Sink.data
		.st_snk_valid                (dispatcher_internal_response_source_valid),                    //                                   .valid
		.st_snk_ready                (dispatcher_internal_response_source_ready),                    //                                   .ready
		.mm_csr_address              (prefetcher_csr_address),                                       //                                Csr.address
		.mm_csr_read                 (prefetcher_csr_read),                                          //                                   .read
		.mm_csr_write                (prefetcher_csr_write),                                         //                                   .write
		.mm_csr_writedata            (prefetcher_csr_writedata),                                     //                                   .writedata
		.mm_csr_readdata             (prefetcher_csr_readdata),                                      //                                   .readdata
		.csr_irq                     (csr_irq_irq),                                                  //                            Csr_Irq.irq
		.mm_read_burstcount          ()                                                              //                        (terminated)
	);

	write_master #(
		.DATA_WIDTH                     (32),
		.LENGTH_WIDTH                   (11),
		.FIFO_DEPTH                     (256),
		.STRIDE_ENABLE                  (0),
		.BURST_ENABLE                   (0),
		.PACKET_ENABLE                  (1),
		.ERROR_ENABLE                   (1),
		.ERROR_WIDTH                    (6),
		.BYTE_ENABLE_WIDTH              (4),
		.BYTE_ENABLE_WIDTH_LOG2         (2),
		.ADDRESS_WIDTH                  (24),
		.FIFO_DEPTH_LOG2                (8),
		.SYMBOL_WIDTH                   (8),
		.NUMBER_OF_SYMBOLS              (4),
		.NUMBER_OF_SYMBOLS_LOG2         (2),
		.MAX_BURST_COUNT_WIDTH          (1),
		.UNALIGNED_ACCESSES_ENABLE      (0),
		.ONLY_FULL_ACCESS_ENABLE        (0),
		.BURST_WRAPPING_SUPPORT         (0),
		.PROGRAMMABLE_BURST_ENABLE      (0),
		.MAX_BURST_COUNT                (1),
		.FIFO_SPEED_OPTIMIZATION        (1),
		.STRIDE_WIDTH                   (1),
		.ACTUAL_BYTES_TRANSFERRED_WIDTH (12)
	) write_mstr_internal (
		.clk                (clock_clk),                                      //             Clock.clk
		.reset              (~reset_n_reset_n),                               //       Clock_reset.reset
		.master_address     (mm_write_address),                               // Data_Write_Master.address
		.master_write       (mm_write_write),                                 //                  .write
		.master_byteenable  (mm_write_byteenable),                            //                  .byteenable
		.master_writedata   (mm_write_writedata),                             //                  .writedata
		.master_waitrequest (mm_write_waitrequest),                           //                  .waitrequest
		.snk_data           (st_sink_data),                                   //         Data_Sink.data
		.snk_valid          (st_sink_valid),                                  //                  .valid
		.snk_ready          (st_sink_ready),                                  //                  .ready
		.snk_sop            (st_sink_startofpacket),                          //                  .startofpacket
		.snk_eop            (st_sink_endofpacket),                            //                  .endofpacket
		.snk_empty          (st_sink_empty),                                  //                  .empty
		.snk_error          (st_sink_error),                                  //                  .error
		.snk_command_data   (dispatcher_internal_write_command_source_data),  //      Command_Sink.data
		.snk_command_valid  (dispatcher_internal_write_command_source_valid), //                  .valid
		.snk_command_ready  (dispatcher_internal_write_command_source_ready), //                  .ready
		.src_response_data  (write_mstr_internal_response_source_data),       //   Response_Source.data
		.src_response_valid (write_mstr_internal_response_source_valid),      //                  .valid
		.src_response_ready (write_mstr_internal_response_source_ready),      //                  .ready
		.master_burstcount  ()                                                //       (terminated)
	);

endmodule
