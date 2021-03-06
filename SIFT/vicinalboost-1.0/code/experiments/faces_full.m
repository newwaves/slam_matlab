% FACES_FULL
%
% Repeat for : PARZEN, TANGENT, TANGENT+GRADIENT
% Repeat for : SIGMA, N

clear ex ;

Nr     = [8000] ;
nfolds = [2   ] ;
sigmar = [0.01 0.4] ;
verb   = 1 ; 
e      = 1 ;

ex_results_path  = 'results/faces_full.mat' ;

for N = Nr
	
	for sigma = sigmar
		for folds = 1:nfolds(find(N == Nr))
			ex{e}.N                 = N ;
			ex{e}.random_seed       = folds ;
			ex{e}.nfolds            = 1 ;
			ex{e}.nwc               = 800 ;
			ex{e}.tg_scale          = 8 ;
			ex{e}.cfg.gd_max_niters = 0 ;
			ex{e}.cfg.gd_method     = 'fr' ;
			ex{e}.cfg.use_tg        = 0 ;
			ex{e}.cfg.sigma         = sigma ;
			ex{e}.cfg.verbosity     = verb ;    
			e = e + 1 ;
		end
	end
	
	for sigma = sigmar
		for folds = 1:nfolds(find(N == Nr))
			ex{e}.N                 = N ;
			ex{e}.random_seed       = folds ;
			ex{e}.nfolds            = 1 ;
			ex{e}.nwc               = 800 ;
			ex{e}.tg_scale          = 8 ;
			ex{e}.cfg.gd_max_niters = 0 ;
			ex{e}.cfg.gd_method     = 'fr' ;
			ex{e}.cfg.use_tg        = 1 ;
			ex{e}.cfg.sigma         = sigma ;
			ex{e}.cfg.verbosity     = verb ;
			e = e + 1 ;
		end
	end
	
	for sigma = sigmar
		for folds = 1:nfolds(find(N == Nr))
			ex{e}.N                 = N ;
			ex{e}.random_seed       = folds ;
			ex{e}.nfolds            = 1 ;
			ex{e}.nwc               = 800 ;
			ex{e}.tg_scale          = 8 ;
			ex{e}.cfg.gd_max_niters = 100 ;
			ex{e}.cfg.gd_method     = 'fr' ;
			ex{e}.cfg.use_tg        = 1 ;
			ex{e}.cfg.sigma         = sigma ;
			ex{e}.cfg.verbosity     = verb ;
			e = e + 1 ;
		end
	end
	
end

faces_driver ;
