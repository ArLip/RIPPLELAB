

%# -*- texinfo -*-
%# @deftypefn {Function File} {} empirical_cdf (@var{x}, @var{data})
%# For each element of @var{x}, compute the cumulative distribution
%# function (CDF) at @var{x} of the empirical distribution obtained from
%# the univariate sample @var{data}.
%# @end deftypefn

%# Author: KH <Kurt.Hornik@wu-wien.ac.at>
%# Description: CDF of the empirical distribution

function cdf = empirical_cdf (x, data)

  if (nargin ~= 2)
    print_usage ;
  end

  if (~ isvector (data))
    error ('empirical_cdf: data must be a vector');
  end

  cdf = discrete_cdf (x, data, ones (size (data)) / length (data));



%# Copyright (C) 1996, 1997, 1998, 2000, 2002, 2005, 2007 Kurt Hornik
%#
%# This file is part of Octave.
%#
%# Octave is free software; you can redistribute it and/or modify it
%# under the terms of the GNU General Public License as published by
%# the Free Software Foundation; either version 3 of the License, or (at
%# your option) any later version.
%#
%# Octave is distributed in the hope that it will be useful, but
%# WITHOUT ANY WARRANTY; without even the implied warranty of
%# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%# General Public License for more details.
%#
%# You should have received a copy of the GNU General Public License
%# along with Octave; see the file COPYING.  If not, see
%# <http://www.gnu.org/licenses/>.
