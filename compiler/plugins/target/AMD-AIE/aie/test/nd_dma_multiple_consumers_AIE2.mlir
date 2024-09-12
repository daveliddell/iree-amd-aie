
// RUN: iree-opt --amdaie-objectFifo-stateful-transform %s | FileCheck %s

// CHECK-LABEL:   aie.device(xcve2302) {
// CHECK:           memref.global "public" @of3 : memref<256xi32>
// CHECK:           memref.global "public" @of1 : memref<256xi32>
// CHECK:           memref.global "public" @of0 : memref<256xi32>
// CHECK-DAG:       %[[TILE_1_2:.*]] = aie.tile(1, 2)
// CHECK-DAG:       %[[TILE_1_3:.*]] = aie.tile(1, 3)
// CHECK-DAG:       %[[TILE_3_3:.*]] = aie.tile(3, 3)
// CHECK-DAG:       %[[TILE_2_2:.*]] = aie.tile(2, 2)
// CHECK-DAG:       %[[TILE_2_3:.*]] = aie.tile(2, 3)
// CHECK-DAG:       %[[OF3_CONS_BUFF_0:.*]] = aie.buffer(%[[TILE_2_3]]) {sym_name = "of3_cons_buff_0_0"} : memref<256xi32>
// CHECK-DAG:       %[[OF3_CONS_BUFF_1:.*]] = aie.buffer(%[[TILE_2_3]]) {sym_name = "of3_cons_buff_0_1"} : memref<256xi32>
// CHECK-DAG:       %[[OF3_CONS_PROD_LOCK:.*]] = aie.lock(%[[TILE_2_3]]) {init = 2 : i8, sym_name = "of3_cons_prod_lock_0"}
// CHECK-DAG:       %[[OF3_CONS_CONS_LOCK:.*]] = aie.lock(%[[TILE_2_3]]) {init = 0 : i8, sym_name = "of3_cons_cons_lock_0"}
// CHECK-DAG:       %[[OF3_BUFF_0:.*]] = aie.buffer(%[[TILE_2_2]]) {sym_name = "of3_prod_buff_0_0"} : memref<256xi32>
// CHECK-DAG:       %[[OF3_BUFF_1:.*]] = aie.buffer(%[[TILE_2_2]]) {sym_name = "of3_prod_buff_0_1"} : memref<256xi32>
// CHECK-DAG:       %[[OF3_PROD_LOCK:.*]] = aie.lock(%[[TILE_2_2]]) {init = 2 : i8, sym_name = "of3_prod_prod_lock_0"}
// CHECK-DAG:       %[[OF3_CONS_LOCK:.*]] = aie.lock(%[[TILE_2_2]]) {init = 0 : i8, sym_name = "of3_prod_cons_lock_0"}
// CHECK-DAG:       %[[OF1_CONS_BUFF_0:.*]] = aie.buffer(%[[TILE_3_3]]) {sym_name = "of1_cons_buff_0_0"} : memref<256xi32>
// CHECK-DAG:       %[[OF1_CONS_BUFF_1:.*]] = aie.buffer(%[[TILE_3_3]]) {sym_name = "of1_cons_buff_0_1"} : memref<256xi32>
// CHECK-DAG:       %[[OF1_CONS_PROD_LOCK:.*]] = aie.lock(%[[TILE_3_3]]) {init = 2 : i8, sym_name = "of1_cons_prod_lock_0"}
// CHECK-DAG:       %[[OF1_CONS_CONS_LOCK:.*]] = aie.lock(%[[TILE_3_3]]) {init = 0 : i8, sym_name = "of1_cons_cons_lock_0"}
// CHECK-DAG:       %[[OF1_BUFF_0:.*]] = aie.buffer(%[[TILE_1_2]]) {sym_name = "of1_prod_buff_0_0"} : memref<256xi32>
// CHECK-DAG:       %[[OF1_BUFF_1:.*]] = aie.buffer(%[[TILE_1_2]]) {sym_name = "of1_prod_buff_0_1"} : memref<256xi32>
// CHECK-DAG:       %[[OF1_PROD_LOCK:.*]] = aie.lock(%[[TILE_1_2]]) {init = 2 : i8, sym_name = "of1_prod_prod_lock_0"}
// CHECK-DAG:       %[[OF1_CONS_LOCK:.*]] = aie.lock(%[[TILE_1_2]]) {init = 0 : i8, sym_name = "of1_prod_cons_lock_0"}
// CHECK-DAG:       %[[OF0_0_CONS_BUFF_0:.*]] = aie.buffer(%[[TILE_1_3]]) {sym_name = "of0_cons_buff_0_0"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_0_CONS_BUFF_1:.*]] = aie.buffer(%[[TILE_1_3]]) {sym_name = "of0_cons_buff_0_1"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_0_CONS_BUFF_2:.*]] = aie.buffer(%[[TILE_1_3]]) {sym_name = "of0_cons_buff_0_2"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_0_CONS_BUFF_3:.*]] = aie.buffer(%[[TILE_1_3]]) {sym_name = "of0_cons_buff_0_3"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_0_CONS_PROD_LOCK:.*]] = aie.lock(%[[TILE_1_3]]) {init = 4 : i8, sym_name = "of0_cons_prod_lock_0"}
// CHECK-DAG:       %[[OF0_0_CONS_CONS_LOCK:.*]] = aie.lock(%[[TILE_1_3]]) {init = 0 : i8, sym_name = "of0_cons_cons_lock_0"}
// CHECK-DAG:       %[[OF0_1_CONS_BUFF_0:.*]] = aie.buffer(%[[TILE_3_3]]) {sym_name = "of0_cons_buff_1_0"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_1_CONS_BUFF_1:.*]] = aie.buffer(%[[TILE_3_3]]) {sym_name = "of0_cons_buff_1_1"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_1_CONS_BUFF_2:.*]] = aie.buffer(%[[TILE_3_3]]) {sym_name = "of0_cons_buff_1_2"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_1_CONS_BUFF_3:.*]] = aie.buffer(%[[TILE_3_3]]) {sym_name = "of0_cons_buff_1_3"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_1_CONS_PROD_LOCK:.*]] = aie.lock(%[[TILE_3_3]]) {init = 4 : i8, sym_name = "of0_cons_prod_lock_1"}
// CHECK-DAG:       %[[OF0_1_CONS_CONS_LOCK:.*]] = aie.lock(%[[TILE_3_3]]) {init = 0 : i8, sym_name = "of0_cons_cons_lock_1"}
// CHECK-DAG:       %[[OF0_BUFF_0:.*]] = aie.buffer(%[[TILE_1_2]]) {sym_name = "of0_prod_buff_0_0"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_BUFF_1:.*]] = aie.buffer(%[[TILE_1_2]]) {sym_name = "of0_prod_buff_0_1"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_BUFF_2:.*]] = aie.buffer(%[[TILE_1_2]]) {sym_name = "of0_prod_buff_0_2"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_BUFF_3:.*]] = aie.buffer(%[[TILE_1_2]]) {sym_name = "of0_prod_buff_0_3"} : memref<256xi32>
// CHECK-DAG:       %[[OF0_PROD_LOCK:.*]] = aie.lock(%[[TILE_1_2]]) {init = 4 : i8, sym_name = "of0_prod_prod_lock_0"}
// CHECK-DAG:       %[[OF0_CONS_LOCK:.*]] = aie.lock(%[[TILE_1_2]]) {init = 0 : i8, sym_name = "of0_prod_cons_lock_0"}
// CHECK-DAG:       aie.flow(%[[TILE_1_2]], DMA : 0, %[[TILE_3_3]], DMA : 0)
// CHECK-DAG:       aie.flow(%[[TILE_1_2]], DMA : 0, %[[TILE_1_3]], DMA : 0)
// CHECK-DAG:       aie.flow(%[[TILE_1_2]], DMA : 1, %[[TILE_3_3]], DMA : 1)
// CHECK-DAG:       aie.flow(%[[TILE_2_2]], DMA : 0, %[[TILE_2_3]], DMA : 0)
// CHECK:           %[[MEM_1_2:.*]] = aie.mem(%[[TILE_1_2]]) {
// CHECK:             %[[VAL_0:.*]] = aie.dma_start(MM2S, 0, ^bb1, ^bb5)
// CHECK:           ^bb1:
// CHECK:             aie.use_lock(%[[OF0_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_BUFF_0]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 16, stride = 1>, <size = 16, stride = 16>, <size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb2
// CHECK:           ^bb2:
// CHECK:             aie.use_lock(%[[OF0_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_BUFF_1]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 16, stride = 1>, <size = 16, stride = 16>, <size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb3
// CHECK:           ^bb3:
// CHECK:             aie.use_lock(%[[OF0_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_BUFF_2]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 16, stride = 1>, <size = 16, stride = 16>, <size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb4
// CHECK:           ^bb4:
// CHECK:             aie.use_lock(%[[OF0_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_BUFF_3]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 16, stride = 1>, <size = 16, stride = 16>, <size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb1
// CHECK:           ^bb5:
// CHECK:             %[[VAL_1:.*]] = aie.dma_start(MM2S, 1, ^bb6, ^bb8)
// CHECK:           ^bb6:
// CHECK:             aie.use_lock(%[[OF1_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF1_BUFF_0]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 128, stride = 2>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF1_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb7
// CHECK:           ^bb7:
// CHECK:             aie.use_lock(%[[OF1_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF1_BUFF_1]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 128, stride = 2>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF1_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb6
// CHECK:           ^bb8:
// CHECK:             aie.end
// CHECK:           }
// CHECK:           %[[MEM_1_3:.*]] = aie.mem(%[[TILE_1_3]]) {
// CHECK:             %[[VAL_2:.*]] = aie.dma_start(S2MM, 0, ^bb1, ^bb5)
// CHECK:           ^bb1:
// CHECK:             aie.use_lock(%[[OF0_0_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_0_CONS_BUFF_0]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_0_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb2
// CHECK:           ^bb2:
// CHECK:             aie.use_lock(%[[OF0_0_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_0_CONS_BUFF_1]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_0_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb3
// CHECK:           ^bb3:
// CHECK:             aie.use_lock(%[[OF0_0_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_0_CONS_BUFF_2]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_0_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb4
// CHECK:           ^bb4:
// CHECK:             aie.use_lock(%[[OF0_0_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_0_CONS_BUFF_3]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 1, stride = 1>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_0_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb1
// CHECK:           ^bb5:
// CHECK:             aie.end
// CHECK:           }
// CHECK:           %[[MEM_3_3:.*]] = aie.mem(%[[TILE_3_3]]) {
// CHECK:             %[[VAL_3:.*]] = aie.dma_start(S2MM, 0, ^bb1, ^bb5)
// CHECK:           ^bb1:
// CHECK:             aie.use_lock(%[[OF0_1_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_1_CONS_BUFF_0]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 3, stride = 4>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_1_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb2
// CHECK:           ^bb2:
// CHECK:             aie.use_lock(%[[OF0_1_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_1_CONS_BUFF_1]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 3, stride = 4>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_1_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb3
// CHECK:           ^bb3:
// CHECK:             aie.use_lock(%[[OF0_1_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_1_CONS_BUFF_2]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 3, stride = 4>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_1_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb4
// CHECK:           ^bb4:
// CHECK:             aie.use_lock(%[[OF0_1_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF0_1_CONS_BUFF_3]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 3, stride = 4>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF0_1_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb1
// CHECK:           ^bb5:
// CHECK:             %[[VAL_4:.*]] = aie.dma_start(S2MM, 1, ^bb6, ^bb8)
// CHECK:           ^bb6:
// CHECK:             aie.use_lock(%[[OF1_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF1_CONS_BUFF_0]] : memref<256xi32>) {len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF1_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb7
// CHECK:           ^bb7:
// CHECK:             aie.use_lock(%[[OF1_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF1_CONS_BUFF_1]] : memref<256xi32>) {len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF1_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb6
// CHECK:           ^bb8:
// CHECK:             aie.end
// CHECK:           }
// CHECK:           %[[MEM_2_2:.*]] = aie.mem(%[[TILE_2_2]]) {
// CHECK:             %[[VAL_5:.*]] = aie.dma_start(MM2S, 0, ^bb1, ^bb3)
// CHECK:           ^bb1:
// CHECK:             aie.use_lock(%[[OF3_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF3_BUFF_0]] : memref<256xi32>) {len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF3_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb2
// CHECK:           ^bb2:
// CHECK:             aie.use_lock(%[[OF3_CONS_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF3_BUFF_1]] : memref<256xi32>) {len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF3_PROD_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb1
// CHECK:           ^bb3:
// CHECK:             aie.end
// CHECK:           }
// CHECK:           %[[MEM_2_3:.*]] = aie.mem(%[[TILE_2_3]]) {
// CHECK:             %[[VAL_6:.*]] = aie.dma_start(S2MM, 0, ^bb1, ^bb3)
// CHECK:           ^bb1:
// CHECK:             aie.use_lock(%[[OF3_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF3_CONS_BUFF_0]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 9, stride = 9>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF3_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb2
// CHECK:           ^bb2:
// CHECK:             aie.use_lock(%[[OF3_CONS_PROD_LOCK]], AcquireGreaterEqual, 1)
// CHECK:             aie.dma_bd(%[[OF3_CONS_BUFF_1]] : memref<256xi32>) {dimensions = #aie<bd_dim_layout_array[<size = 9, stride = 9>]>, len = 256 : i32}
// CHECK:             aie.use_lock(%[[OF3_CONS_CONS_LOCK]], Release, 1)
// CHECK:             aie.next_bd ^bb1
// CHECK:           ^bb3:
// CHECK:             aie.end
// CHECK:           }
// CHECK:         }
module @ndDMAObjFifoAIE2 {
  aie.device(xcve2302) {
    %tile12 = aie.tile(1, 2)
    %tile13 = aie.tile(1, 3)
    %tile33 = aie.tile(3, 3)
    %tile22 = aie.tile(2, 2)
    %tile23 = aie.tile(2, 3)
    aie.flow(%tile12, DMA : 0, %tile33, DMA : 0) {symbol = @of0}
    aie.flow(%tile12, DMA : 0, %tile13, DMA : 0) {symbol = @of0}
    aie.flow(%tile12, DMA : 1, %tile33, DMA : 1) {symbol = @of1}
    aie.flow(%tile22, DMA : 0, %tile23, DMA : 0) {symbol = @of3}
    aie.objectfifo @of0 (%tile12 toStream [<size = 16, stride = 1>, <size = 16, stride = 16>, <size = 1, stride = 1>], // transpose
                          {%tile13 fromStream [<size = 1, stride = 1>],
                          %tile33 fromStream [<size = 3, stride = 4>]},
                          4 : i32) : !aie.objectfifo<memref<256xi32>>
    aie.objectfifo @of1 (%tile12 toStream [<size = 128, stride = 2>], {%tile33},
                          2 : i32) : !aie.objectfifo<memref<256xi32>>
    aie.objectfifo @of3 (%tile22, {%tile23 fromStream [<size = 9, stride = 9>]},
                          2 : i32) : !aie.objectfifo<memref<256xi32>>
  }
}