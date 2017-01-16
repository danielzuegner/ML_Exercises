function [ row,col ] = stateToCoord( state, gridSize )
%STATETOCOORD Summary of this function goes here
%   Detailed explanation goes here
    col = ceil(state / gridSize); 
    row = mod(state - 1, gridSize) + 1;

end

