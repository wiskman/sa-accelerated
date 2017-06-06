function [mu, sigma]=logen(x1, x2)
sigma=(log(x2)-log(x1))/(norminv(0.95, 0, 1)-norminv(0.05, 0, 1));
mu=(log(x1)*norminv(0.95, 0, 1)-log(x2)*norminv(0.05, 0, 1))/(norminv(0.95, 0, 1)-norminv(0.05, 0, 1));
end