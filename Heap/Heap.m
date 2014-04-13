classdef Heap<handle
    %% 
    % Heap is a class for representing heap data types
    % Inherits from handle class
    % 
    % Implements heap data type.
    %
    % properties:
    %       h- an array in which the data is stored
    %       heapSize- the size of the heap
    % methods:
    %       Heap- constructor for the Heap class, accepts numeric arrays as
    %       an input
    %       heapSort- method for performing sorting, runtime
    %       O(nlogn),although, very, very slow... not to be used for
    %       sorting arrays!!!
    %       heapMaximum- returns maximum in the heap
    %       heapExtractMax- extracts maximum value from the heap
    %       heapIncreaseKey- increses the key in the postion i
    %       maxKeyInsert- inserts a key in the heap
    %
    % made by Hanan Kavitz
    % free for distribution
    properties(Access=private)
        h
        heapSize
    end
    
    methods
        
        function heap=Heap(a)
            l=numel(a);
            heap.h=a;
            heap.heapSize=l;
            for i=floor(l/2):-1:1
                maxHeapify(heap,i)
            end
        end
        
        function b=heapSort(heap)
            b=zeros(size(heap.h));
            for i=heap.heapSize:-1:1
                temp=heap.h(1);
                heap.h(1)=heap.h(i);
                heap.h(i)=temp;
                %exchange(heap,1,i);
                b(i)=heap.h(i);
                heap.h(heap.heapSize)=[];
                heap.heapSize=heap.heapSize-1;
                maxHeapify(heap,1);
            end
            
        end
        
        function max=heapMaximum(heap)
            max=heap.h(1);
        end
        
        function max=heapExtractMax(heap)
            if heap.heapSize<1
                error('heap underflow');
            end
            max=heapMaximum(heap);
            heap.h(1)=heap.h(heap.heapSize);
            heap.h(heap.heapSize)=[];
            heap.heapSize=heap.heapSize-1;
            maxHeapify(heap,1);
        end
        
        function heapIncreaseKey(heap,i,key)
            if key<heap.h(i).key
                error('new key is smaller than current key');
            end
            heap.h(i).key=key;
            while i>1 && heap.h(heap.parent(i)).key<heap.h(i).key
                
                temp=heap.h(i);
                heap.h(i)=heap.h(heap.parent(i));
                heap.h(heap.parent(i))=temp;
                %exchange(heap,i,heap.parent(i));
                i=heap.parent(i);
            end
            
        end
        
        function maxHeapInsert(heap,obj)
            heap.heapSize=heap.heapSize+1;
            
            heap.h(heap.heapSize) = obj;
            heap.h(heap.heapSize).key=-Inf;
            heapIncreaseKey(heap,heap.heapSize,obj.key);
        end
    end
    methods(Access=private)    
    
        function maxHeapify(heap,i)
            l=Heap.left(i);
            r=Heap.right(i);
            if l<=heap.heapSize && heap.h(l).key>heap.h(i).key
                largest=l;
            else
                largest=i;
                
            end
            
            if r<=heap.heapSize && heap.h(r).key>heap.h(largest).key
                largest=r;
            end
            
            if largest~=i
                temp=heap.h(i);
                heap.h(i)=heap.h(largest);
                heap.h(largest)=temp;
%                 exchange(heap,i,largest)
                maxHeapify(heap,largest);
            end
            
        end
        
       
    end
    methods(Static,Access=private)
        function l=left(i)
            l=2*i;
        end
        
        function r=right(i)
            r=2*i+1;
        end
        
        function p=parent(i)
            p=floor(i/2);
        end
    end
end