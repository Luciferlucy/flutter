abstract class NewsStates {}
class NewsInitialState extends NewsStates{}
class NewsbottomNavState extends NewsStates{}
class NewsLoadingState extends NewsStates{}
class NewGetBusinessSuccessState extends NewsStates{}
class NewGetBusinessErrorState extends NewsStates {
  final String error;
  NewGetBusinessErrorState(this.error);
}

class NewsSportLoadingState extends NewsStates{}
class NewGetSportsSuccessState extends NewsStates{}
class NewGetSportsErrorState extends NewsStates {
  final String error;
  NewGetSportsErrorState(this.error);
}

class NewsScienceLoadingState extends NewsStates{}
class NewGetScienceSuccessState extends NewsStates{}
class NewGetScienceErrorState extends NewsStates {
  final String error;
  NewGetScienceErrorState(this.error);
}

class NewsSearchLoadingState extends NewsStates{}
class NewGetSearchSuccessState extends NewsStates{}
class NewGetSearchErrorState extends NewsStates {
  final String error;
  NewGetSearchErrorState(this.error);
}


