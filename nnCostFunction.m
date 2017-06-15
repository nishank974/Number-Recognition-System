function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight
% matrices
% for our 2 layer neural network
% size(nn_params)
% size(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end))
% a=num
% inputlayer=input_layer_size
% numlab=num_labels
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
d=0;
for i=1:m
    a1=sigmoid(Theta1*[1;X(i,:)']);
    h=sigmoid(Theta2*[1;a1]);
    k=[1;2;3;4;5;6;7;8;9;10];
    z=(k==y(i));
    n=0;
    for k=1:num_labels
        n=n+(-z(k)*log(h(k))-(1-z(k))*log(1-h(k)));
    end
    a(i)=n;
    d=d+n;
end
% max(a)
% mean(a)
         
% You need to return the following variables correctly 
J = (sum(a)/m)+(lambda/(2*m))*(sum(sum((Theta1(:,2:input_layer_size+1)).^2))+sum(sum((Theta2(:,2:hidden_layer_size+1)).^2)));
%BACK PROPOGATION
D1=zeros(hidden_layer_size,input_layer_size+1);D2=zeros(num_labels,hidden_layer_size+1);
for i=1:m
    a1=sigmoid(Theta1*[1;X(i,:)']);
    h=sigmoid(Theta2*[1;a1]);
%     size(a1)
%     disp(h)
%     size(z)
    for j=1:num_labels
        k(j)=j;
    end
    z=(k==y(i));
    z=z';
    d3=(h-z);
%     t2=size(Theta2)
%     dt=size(d3)
    d2=((Theta2)'*d3).*sigmoidGradient([1;Theta1*[1;X(i,:)']]);
    D1=D1+d2(2:end)*[1;X(i,:)']';
    D2=D2+d3*[1;a1]';
end
Theta1_grad = D1/m;
Theta1_grad = [Theta1_grad(:,1) Theta1_grad(:,2:end)+(lambda/m)*Theta1(:,2:end)];
Theta2_grad = D2/m;
Theta2_grad = [Theta2_grad(:,1) Theta2_grad(:,2:end)+(lambda/m)*Theta2(:,2:end)];

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial
%         derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%



















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
