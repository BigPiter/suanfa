//
//  main.m
//  testRev
//
//  Created by 张积涛 on 2018/2/23.
//  Copyright © 2018年 张积涛. All rights reserved.
//

#import <Foundation/Foundation.h>

// 倒序输出
void printListRev(NSArray *arr, int index) {
    if (index < arr.count) {
        printListRev(arr, index + 1);
        NSLog(@"%@",arr[index]);
    }
}

// 二分查找
int binSearch(NSArray *arr, NSNumber *data) {
    int low = 0;
    int high = (int)arr.count - 1;
    while (low <= high) {
        int mid = (low + high) / 2;
        if (data == arr[mid]) {
            return mid;
        }
        else if (data < arr[mid]) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return -1;
}

// 堆排序
void swap(NSMutableArray *arr, int low, int high) {
    NSNumber *temp = arr[low];
    arr[low] = arr[high];
    arr[high] = temp;
}

void heapAdjust(NSMutableArray *arr, int index, int n) {
    NSNumber *temp = arr[index];
    int child = 0;
    
    while (index * 2 + 1 < n) {
        child = index *2 + 1;
        
        if (child != n - 1 && arr[child] < arr[child + 1]) {
            child++;
        }
        
        if (temp > arr[child]) {
            break;
        } else {
            arr[index] = arr[child];
            index = child;
        }
    }
    
    arr[index] = temp;
}

void heapSort(NSMutableArray *arr, int n) {
    for (int i = n / 2 -1; i >= 0; i--) {
        heapAdjust(arr, i, n);
    }
    
    for (int i = 0; i < n - 1; i ++) {
        swap(arr, 0, n - i - 1);
        heapAdjust(arr, 0, n - i - 1);
    }
}



// 快速排序
// 主要思想是：在待排序的序列中选择一个称为主元的元素，将数组分为两部分，使得第一部分中的所有元素都小于或等于主元，而第二部分中的所有元素都大于主元，然后对两部分递归地应用快速排序算法。
// 快速排序前的划分
int quickSortPartition(NSMutableArray *list, int first, int last) {
    NSNumber *pivot = list[first];
    int low = first + 1;
    int high = last;
    
    while (high > low) {
        while (low <= high && list[low] <= pivot) {
            low ++;
        }
        
        while (low <= high && list[high] >= pivot) {
            high --;
        }
        
        if (high > low) {
            NSNumber* temp = list[high];
            list[high] = list[low];
            list[low] = temp;
        }
    }
    
    while (high > first && list[high] >= pivot) {
        high --;
    }
    
    if (pivot > list[high]) {
        list[first] = list[high];
        list[high] = pivot;
        return high;
    } else {
        return first;
    }
}

void quickSort(NSMutableArray *mdata, int start, int end) {
    if (end > start) {
        int pivotIndex = quickSortPartition(mdata, start, end);
        quickSort(mdata, start, pivotIndex - 1);
        quickSort(mdata, pivotIndex + 1, end);
    }
}


// 归并排序

// 主要思想是：将待排序序列分为两部分，对每部分递归地应用归并排序，在两部分都排好序后进行合并。
NSMutableArray* merge(NSMutableArray *arr1, NSMutableArray *arr2) {
    NSMutableArray *arr3 = [NSMutableArray array];
    
    int count1 = 0;
    int count2 = 0;
    int count3 = 0;
    
    while (count1 < arr1.count && count2 < arr2.count) {
        if (arr1[count1] < arr2[count2]) {
            arr3[count3++] = arr1[count1++];
        } else {
            arr3[count3++] = arr2[count2++];
        }
    }
    
    while (count1 < arr1.count) {
        arr3[count3++] = arr1[count1++];
    }
    
    while (count2 < arr2.count) {
        arr3[count3++] = arr1[count2++];
    }
    
    return arr3;
}

void mergeSort(NSMutableArray *arr) {
    if (arr.count > 1) {
        int length1 = (int)arr.count / 2;
        NSMutableArray *arr1 = [arr subarrayWithRange:NSMakeRange(0, length1)].mutableCopy;
        mergeSort(arr1);

        NSInteger length2 = arr.count - length1;
        NSMutableArray *arr2 = [arr subarrayWithRange:NSMakeRange(length1, length2)].mutableCopy;
        mergeSort(arr2);

        NSMutableArray *mergeArr = merge(arr1, arr2);
        
        NSLog(@"%@",mergeArr);
    }
}



// 直接插入排序
void DInsertSort(NSMutableArray *arr) {
    for (int i = 1; i < arr.count; i ++) {
        NSNumber *temp = arr[i];
        int j = i - 1;
        while (j > -1 && temp < arr[j]) {
            
            arr[j + 1] = arr[j]; // 2 3 3 5  j = 1 temp = 1 ===> 2 2 3 5
            j --;
        }
        // 3 3 1 5 => 2 3 1 5
        // 2 3 3 5 => 2 2 3 5 => 1 2 3 5
        arr[j + 1] = temp;
    }
}

// 简单选择排序
// 排序序列(3,2,1,5)的过程是，进行3次选择，第1次选择在4个记录中选择最小的值为1，放在第1个位置，得到序列(1,3,2,5)，第2次选择从位置1开始的3个元素中选择最小的值2放在第2个位置，得到有序序列(1,2,3,5)，第3次选择因为最小的值3已经在第3个位置不需要操作，最后得到有序序列（1,2,3,5）。
void selectSort(NSMutableArray *arr) {
    for (int i = 0; i < arr.count - 1; i ++) {
        int mink = i;
        
        for (int j = i + 1; j < arr.count; j ++) {
            if (arr[j] < arr[mink]) {
                mink = j;
            }
        }
        
        if (mink != i) {
            NSNumber *temp = arr[mink];
            arr[mink] = arr[i];
            arr[i] = temp;
        }
    }
}

// 冒泡排序
// 对序列(3,2,1,5)进行排序的过程是：共进行3次遍历，第1次遍历时先比较3和2，交换，继续比较3和1,交换，再比较3和5，不交换，这样第1次遍历结束，最大值5在最后的位置，得到序列(2,1,3,5)。第2次遍历时先比较2和1，交换，继续比较2和3，不交换，第2次遍历结束时次大值3在倒数第2的位置，得到序列(1,2,3,5)，第3次遍历时，先比较1和2，不交换，得到最终有序序列(1,2,3,5)。
void bubbleSort(NSMutableArray *arr) {
    BOOL flag = true;
    for (int i = 0; i < arr.count -1 && flag; i ++) {
        flag = false;
        for (int j = 0; j < arr.count - i -1; j++) {
            if (arr[j] > arr[j + 1]) {
                NSNumber *temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
                flag = true;
            }
        }
    }
}

//斐波那契数列 递归实现
static long funFib(long index) {
    
    if (index == 0) {
        return 0;
    } else if (index == 1) {
        return 1;
    } else {
        return funFib(index - 1) + funFib(index - 2);
    }
}

// 不用递归
static long funFib2(long index) {
    
    long f0 = 0;
    long f1 = 1;
    long f2 = 1;
    
    if (index == 0) {
        return f0;
    } else if (index == 1) {
        return f1;
    } else if (index == 2) {
        return f2;
    }
    
    for (int i = 3; i <= index; i++) {
        f0 = f1;
        f1 = f2;
        f2 = f0 + f1;
    }
    
    return f2;
}

// 不用中间temp交换a、b
static void funSwapTwo(int a, int b) {
    
    a = a ^ b;
    b = b ^ a;
    a = a ^ b;
    
}

// 判断素数
static BOOL funIsPrime(int m) {
    
    BOOL flag = YES;
    
    if (m == 1) {
        flag = false;
    } else {
        
        for (int i = 2; i <= sqrt(m); i++) {
            if (m % i == 0) {
                flag = NO;
                break;
            }
        }
    }
    
    return flag;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        
        NSArray *arr = @[@1,@2,@3,@4];
        
        printListRev(arr,0);
        
        funFib(5);
        
    }
    return 0;
}




