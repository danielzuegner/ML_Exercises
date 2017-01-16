function [ state ] = coordToState( row,col, gridSize )
%COORDTOSTATE Summary of this function goes here
%   Detailed explanation goes here
    state = row * gridSize + col;

end

